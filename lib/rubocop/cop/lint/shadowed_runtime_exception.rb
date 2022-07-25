# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      class ShadowedRuntimeException < Base
        include RescueNode
        include RangeHelp

        MSG = 'Do not shadow rescued Exceptions.'

        # lib/rubocop/ast/node/const_node.rb:10
        def build_full_exception_name(one_rescue)
          namespace  = one_rescue[0].each_path.map {|e| e.short_name}
          class_name = one_rescue[0].short_name

          namespace << class_name

          namespace
        end

        def on_rescue(node)
          require "json"
          require 'pry'
          require "awesome_print"

          return if rescue_modifier?(node)

          _body, *rescues, _else = *node

          # jj rescues

          $all_elements = []
          rescued_groups = rescued_groups_for(rescues)

          result = $all_elements.map do |node|
            build_full_exception_name(node)
          end

          # binding.pry
          # ap result

          puts result.map {|e| e.join("::")}

          rescue_group_rescues_multiple_levels = rescued_groups.any? do |group|
            contains_multiple_levels_of_exceptions?(group)
          end

          return if !rescue_group_rescues_multiple_levels && sorted?(rescued_groups)

          # add_offense(offense_range(rescues))
        end

        private

        def offense_range(rescues)
          shadowing_rescue = find_shadowing_rescue(rescues)
          expression = shadowing_rescue.loc.expression
          range_between(expression.begin_pos, expression.end_pos)
        end

        def rescued_groups_for(rescues)
          rescues.map { |group| evaluate_exceptions(group) }
        end

        def contains_multiple_levels_of_exceptions?(group)
          # Always treat `Exception` as the highest level exception.
          return true if group.size > 1 && group.include?(Exception)

          group.combination(2).any? { |a, b| compare_exceptions(a, b) }
        end

        def compare_exceptions(exception, other_exception)
          if system_call_err?(exception) && system_call_err?(other_exception)
            # This condition logic is for special case.
            # System dependent error code depends on runtime environment.
            # For example, whether `Errno::EAGAIN` and `Errno::EWOULDBLOCK` are
            # the same error code or different error code depends on runtime
            # environment. This checks the error code for that.
            exception.const_get(:Errno) != other_exception.const_get(:Errno) &&
              exception <=> other_exception
          else
            exception && other_exception && exception <=> other_exception
          end
        end

        def system_call_err?(error)
          error && error.ancestors[1] == SystemCallError
        end

        def evaluate_exceptions(group)
          rescued_exceptions = group.exceptions
          # require 'pry'; binding.pry

          # require "json"; jj rescued_exceptions
          # require "awesome_print"; ap rescued_exceptions

          $all_elements << rescued_exceptions


          if rescued_exceptions.any?
            # TODO
            [StandardError]
          else
            # treat an empty `rescue` as `rescue StandardError`
            [StandardError]
          end
        end

        def sorted?(rescued_groups)
          rescued_groups.each_cons(2).all? do |x, y|
            if x.include?(Exception)
              false
            elsif y.include?(Exception) ||
                  # consider sorted if a group is empty or only contains
                  # `nil`s
                  x.none? || y.none?
              true
            else
              (x <=> y || 0) <= 0
            end
          end
        end

        # @param [RuboCop::AST::Node] rescue_group is a node of array_type
        def rescued_exceptions(rescue_group)
          klasses = *rescue_group
          klasses.map do |klass|
            next unless klass.const_type?

            klass.source
          end.compact
        end

        def find_shadowing_rescue(rescues)
          rescued_groups = rescued_groups_for(rescues)
          rescued_groups.zip(rescues).each do |group, res|
            return res if contains_multiple_levels_of_exceptions?(group)
          end

          rescued_groups.each_cons(2).with_index do |group_pair, i|
            return rescues[i] unless sorted?(group_pair)
          end
        end
      end
    end
  end
end
