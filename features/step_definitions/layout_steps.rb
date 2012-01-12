
Given /^the test layout$/ do
  step "the test layout are set"
end

Given /^a clear layout setting$/ do
  delete '/_control/layout'
end

When /^the layout is fetched$/ do
  get "/_control/layout"
end

When /^the test layout are set$/ do
  test_layout_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "test.yml"))
  post_yml "/_control/layout", test_layout_filename
end

When /^the invalid layout are set$/ do
  invalid_layout_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "invalid.yml"))
  post_yml "/_control/layout", invalid_layout_filename
end
