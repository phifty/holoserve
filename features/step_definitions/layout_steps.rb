
Given /^the test layout$/ do
  step "the test yaml layout are set"
end

Given /^a clear layout setting$/ do
  delete '/_control/layout'
end

When /^the layout is fetched in format (\w+)$/ do |format|
  get "/_control/layout.#{format}"
end

When /^the (test|invalid) (yaml|json|invalid) layout are set$/ do |test_or_invalid, format|
  layout_filename = File.expand_path(File.join(File.dirname(__FILE__), "..", "layouts", "#{test_or_invalid}.#{format}"))
  post_file "/_control/layout.#{format}",
            layout_filename,
            { :yaml => "application/x-yaml", :json => "application/json" }[format.to_sym]
end
