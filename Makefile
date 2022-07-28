demo0:
	exe/rubocop --only Lint/ShadowedException spec/fixtures/shawdowed_runtime_exception3.rb

demo1:
	exe/rubocop --only Lint/ShadowedRuntimeException spec/fixtures/shawdowed_runtime_exception1.rb

demo2:
	exe/rubocop --only Lint/ShadowedRuntimeException spec/fixtures/shawdowed_runtime_exception2.rb

demo3:
	exe/rubocop --only Lint/ShadowedRuntimeException spec/fixtures/shawdowed_runtime_exception3.rb

# TODO Object.const_get("RestClient::MethodNotAllowed") > Object.const_get("RestClient::RequestFailed")
# Object.const_get("RuntimeError") > Object.const_get("FrozenError") # true -> runtime error 更加general

