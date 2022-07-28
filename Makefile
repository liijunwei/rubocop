demo0:
	exe/rubocop --only Lint/ShadowedException spec/fixtures/shawdowed_runtime_exception1.rb

demo1:
	exe/rubocop --only Lint/ShadowedRuntimeException spec/fixtures/shawdowed_runtime_exception1.rb

demo2:
	exe/rubocop --only Lint/ShadowedRuntimeException spec/fixtures/shawdowed_runtime_exception2.rb

demo3:
	exe/rubocop --only Lint/ShadowedRuntimeException spec/fixtures/shawdowed_runtime_exception3.rb
