
Given /^the situation '([^']+)'$/ do |situation|
  step "the situation '#{situation}' is set to be the current one"
end

When /^the situation '([^']+)' is set to be the current one$/ do |situation|
  put "/_control/situation/#{situation}"
end

Then /^the current situation should be '([^']+)'$/ do |situation|
  get "/_control/situation"
  last_response_body.should == situation
end
