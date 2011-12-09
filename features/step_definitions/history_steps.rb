
Given /^a clear history$/ do
  delete "/_control/history"
end

Then /^the history should contain the ((test|unhandled) (post|put|get|delete) pair name)$/ do |pair_name, type, method|
  get "/_control/history"
  last_json_response_body.should include(pair_name)
end

Then /^the history should contain the pair name '([^']+)'$/ do |pair_name|
  get "/_control/history"
  last_json_response_body.should include(pair_name)
end

Then /^the history should be empty$/ do
  get "/_control/history"
  last_json_response_body.should be_empty
end
