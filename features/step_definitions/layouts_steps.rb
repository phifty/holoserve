
Given /^the test layouts$/ do
  step "the test layouts are set"
end

Given /^the layout '([^']+)'$/ do |layout|
  step "the layout '#{layout}' is set to be the current layout"
end

Given /^a clear layouts setting$/ do
  delete '/_control/layouts'
end

When /^the test layouts are set$/ do
  test_layouts_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "test.yml"))
  post_yml "/_control/layouts", test_layouts_filename
end

When /^the invalid layouts are set$/ do
  invalid_layouts_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "invalid.yml"))
  post_yml "/_control/layouts", invalid_layouts_filename
end

When /^the layout '([^']+)' is set to be the current layout$/ do |layout|
  put "/_control/layouts/#{layout}/current"
end

Then /^the current layout should be '([^']+)'$/ do |layout|
  get "/_control/layouts/current"
  last_response_body.should == layout
end
