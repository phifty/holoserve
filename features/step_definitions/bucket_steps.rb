
Then /^the bucket should contain the ((test|unhandled) (post|put|get|delete) request)$/ do |request, type, method|
  get "/_control/bucket/requests"
  last_json_response_body.should include(request)
end
