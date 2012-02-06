
Given /^no history$/ do
  step "the history is cleared"
end

Given /^a history containing only the test pair name$/ do
  step "no history"
  step "the test request is performed"
end

When /^the history is cleared$/ do
  delete "/_control/history"
end

Then /^the history should be empty$/ do
  get "/_control/history"
  last_json_response_body.should be_empty
end

Then /^the history should contain the test pair name$/ do
  get "/_control/history"
  last_json_response_body.should include("test_request")
end
