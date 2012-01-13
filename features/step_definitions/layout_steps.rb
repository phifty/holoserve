
Given /^the test layout$/ do
  step "the test yaml layout are set"
end

Given /^a clear layout setting$/ do
  delete '/_control/layout'
end

When /^the layout is fetched in format (\w+)$/ do |format|
  get "/_control/layout.#{format}"
end

When /^the test yaml layout are set$/ do
  test_layout_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "test.yaml"))
  post_yaml "/_control/layout.yaml", test_layout_filename
end

When /^the invalid yaml layout are set$/ do
  invalid_layout_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "invalid.yaml"))
  post_yaml "/_control/layout.yaml", invalid_layout_filename
end
