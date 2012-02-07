
Given /^no situation$/ do
  step "the current situation is cleared"
end

Given /^the situation '([^']+)'$/ do |situation|
  step "the situation '#{situation}' is set to be the current one"
end

When /^the situation '([^']+)' is set to be the current one$/ do |situation|
  put "/_control/situation", :name => situation
end

When /^the current situation is cleared$/ do
  put "/_control/situation", :name => nil
end

Then /^the current situation should be '([^']+)'$/ do |situation|
  get "/_control/situation"
  last_json_response_body.should == { "name" => situation }
end

Then /^there should be no situation set$/ do
  get "/_control/situation"
  last_response_status.should == 200
  last_json_response_body.should == { "name" => nil }
end
