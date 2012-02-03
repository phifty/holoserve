
Given /^no situation$/ do
  step "the current situation is cleared"
end

Given /^the situation '([^']+)'$/ do |situation|
  step "the situation '#{situation}' is set to be the current one"
end

When /^the situation '([^']+)' is set to be the current one$/ do |situation|
  put "/_control/situation/#{situation}"
end

When /^the current situation is cleared$/ do
  delete "/_control/situation"
end

Then /^the current situation should be '([^']+)'$/ do |situation|
  get "/_control/situation"
  last_response_body.should == situation
end

Then /^there should be no situation set$/ do
  get "/_control/situation"
  last_response_status.should == 200
  last_response_body.should == ""
end
