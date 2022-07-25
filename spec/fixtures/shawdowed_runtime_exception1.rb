# frozen_string_literal: true

require "rest-client"
require "pry"
require "json"

class ShawdowedExceptionFixture
  def run
    puts "running..."
  rescue Exception => e
    puts "msg for Exception"
  rescue StandardError => e
    puts "msg for StandardError"
  rescue RestClient::RequestFailed => e
    puts "msg for RestClient::RequestFailed"
  rescue RestClient::MethodNotAllowed => e
    puts "msg for RestClient::MethodNotAllowed"
  end
end
