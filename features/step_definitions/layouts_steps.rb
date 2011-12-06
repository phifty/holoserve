
Given /^the test layouts$/ do

end

When /^the test layouts are set$/ do
  post "/_control/layouts", File.read(File.join(File.dirname(__FILE__), "..", "layouts", "test.yml"))
end

When /^the layout '([^']+)' is set to be the current layout$/ do |layout|
  put "/_control/layouts/#{layout}"
end

Then /^the current layout should be '([^']+)'$/ do |layout|
  get "/_control/layouts/current"
  last_response.body.should == layout
end

Then /^the available layouts should include '([^']+)'$/ do |layout|
  get "/_control/layouts/ids"
  last_json_response_body.should include(layout)
end
