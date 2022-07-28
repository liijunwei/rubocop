# frozen_string_literal: true


def run
  begin
    puts "running..."
  rescue FrozenError => e
    puts "msg for FrozenError"
  # TODO 这种情况, 用ShadowedRuntimeException还扫不出来
  rescue RuntimeError, NameError => e
    puts "msg for RuntimeError, NameError"
  end
end
