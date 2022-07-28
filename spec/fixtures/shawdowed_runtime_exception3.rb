# frozen_string_literal: true

def run
  begin
    puts "running..."
  rescue RuntimeError => e
    puts "msg for RuntimeError"
  rescue FrozenError => e
    puts "msg for FrozenError"
  end
end
