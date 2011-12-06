
Given /^the test layouts$/ do

end

When /^the layout '([^']+)' is set to be the current layout$/ do |layout|
  put "/_control/layouts/#{layout}"
end

Then /^the current layout should be '([^']+)'$/ do |layout|
  get "/_control/layouts"
  last_response.body.should == layout
end
