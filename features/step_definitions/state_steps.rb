
Given /^the test state$/ do
  step "the state of resource 'test' is set to 'value'"
end

Given /^no defined state$/ do
  step "the state is cleared"
end

When /^the state of resource '([^']+)' is set to '([^']+)'$/ do |resource, state|
  put "/_control/state", resource => state
end

When /^the state is cleared$/ do
  delete "/_control/state"
end

Then /^the state of resource '([^']+)' should be '([^']+)'$/ do |resource, state|
  get "/_control/state"
  last_response_status.should == 200
  last_json_response_body.keys.should include(resource)
  last_json_response_body[resource].should == state
end

Then /^the state should be undefined$/ do
  get "/_control/state"
  last_response_status.should == 200
  last_json_response_body.should == { }
end
