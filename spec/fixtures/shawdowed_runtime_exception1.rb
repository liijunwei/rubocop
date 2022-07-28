# frozen_string_literal: true

require "rest-client"

class ShawdowedExceptionFixture
  def run
    puts "running..."
  rescue RestClient::RequestFailed => e
    puts "msg for RestClient::RequestFailed"
  rescue RestClient::MethodNotAllowed => e
    puts "msg for RestClient::MethodNotAllowed"
  end
end
