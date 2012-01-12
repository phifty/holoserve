
Given /^the test layouts$/ do
  step "the test layouts are set"
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
