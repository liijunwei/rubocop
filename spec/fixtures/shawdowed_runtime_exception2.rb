# frozen_string_literal: true

require "rest-client"
require "pry"
require "json"

module A
  class BaseError < StandardError; end
  class Level1AError < BaseError; end
  class Level2Error < Level1AError; end
  class Level3Error < Level2Error; end
end

module A
  module B
    class BaseError < StandardError; end
    class Level1AError < BaseError; end
    class Level2Error < Level1AError; end
    class Level3Error < Level2Error; end
  end
end

class BaseError < StandardError; end
class Level1AError < BaseError; end
class Level2Error < Level1AError; end
class Level3Error < Level2Error; end

class ShawdowedRuntimeExceptionFixture
  def run
    puts "running..."
  rescue A::B::BaseError => e
    puts "msg for BaseError"
  rescue A::B::Level1AError => e
    puts "msg for Level1AError"
  rescue A::B::Level2Error => e
    puts "msg for Level2Error"
  rescue A::B::Level3Error => e
    puts "msg for Level3Error"
  rescue BaseError => e
    puts "msg for BaseError"
  rescue Level1AError => e
    puts "msg for Level1AError"
  rescue Level2Error => e
    puts "msg for Level2Error"
  rescue Level3Error => e
    puts "msg for Level3Error"
  rescue A::BaseError => e
    puts "msg for BaseError"
  rescue A::Level1AError => e
    puts "msg for Level1AError"
  rescue A::Level2Error => e
    puts "msg for Level2Error"
  rescue A::Level3Error => e
    puts "msg for Level3Error"
  end
end
