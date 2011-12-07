
Given /^the test layouts$/ do
  When "the test layouts are set"
end

When /^the test layouts are set$/ do
  test_layouts_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "test.yml"))
  post "/_control/layouts", :file => Rack::Test::UploadedFile.new(test_layouts_filename, "application/x-yaml")
end

When /^the invalid layouts are set$/ do
  invalid_layouts_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "invalid.yml"))
  post "/_control/layouts", :file => Rack::Test::UploadedFile.new(invalid_layouts_filename, "application/x-yaml")
end

When /^the layout '([^']+)' is set to be the current layout$/ do |layout|
  put "/_control/layouts/#{layout}/current"
end

Then /^the current layout should be '([^']+)'$/ do |layout|
  get "/_control/layouts/current"
  last_response.body.should == layout
end

Then /^the available layouts should include '([^']+)'$/ do |layout|
  get "/_control/layouts/ids"
  last_json_response_body.should include(layout)
end

Then /^the available layouts should not include '([^']+)'$/ do |layout|
  get "/_control/layouts/ids"
  last_json_response_body.should_not include(layout)
end
