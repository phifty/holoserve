
When /^the test request is performed$/ do
  get "/test-request"
end

When /^the test request is performed with the test parameters$/ do
  get "/test-parameters", :test => "value"
end

When /^the test request is performed with the test headers$/ do
  get "/test-headers", { }, "test" => "value"
end

When /^the test json request is performed$/ do
  get "/test-json"
end

When /^the test request is performed with the test oauth headers$/ do
  get "/test-oauth", { }, "authorization" => "OAuth test=\"value\""
end

When /^the test unhandled request is performed$/ do
  get "/test-unhandled"
end
