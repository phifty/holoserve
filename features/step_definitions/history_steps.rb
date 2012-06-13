
Given /^no history$/ do
  step "the history is cleared"
end

Given /^a history containing only the test pair name$/ do
  step "no history"
  step "the test request is performed"
end

Given /^a history exists$/ do
  perform({"method" => "GET", "path" => "/test-headers"})
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
  last_json_response_body[0]["id"].should == "test_request"
end

Then /^the history should contain the test pair name at the last position$/ do
  get "/_control/history"
  last_json_response_body[last_json_response_body.length-1]["id"].should == "test_request"
end

Then /^the history should contain the response variant$/ do
  get "/_control/history"
  last_json_response_body[0]["request_variant"].should == "default"
end

Then /^the history should contain the list of response variants$/ do
  get "/_control/history"
  last_json_response_body[0]["response_variants"].should == ["default","test_body"]
end