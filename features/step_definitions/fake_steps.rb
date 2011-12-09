
When /^the (test (post|put|get|delete) request) is performed$/ do |request, method|
  perform request
end

When /^the (test (post|put|get|delete) request) is performed with (parameter set '([^']+)')$/ do |request, method, parameter_set, parameter_set_name|
  perform request.merge(parameter_set)
end

When /^the (test (post|put|get|delete) request) is performed with (header set '([^']+)')$/ do |request, method, header_set, header_set_name|
  perform request.merge(header_set)
end

When /^the (unhandled (post|put|get|delete) request) is performed$/ do |request, method|
  @expected_response = { :status => 404, :body => "no response found for this request" }
  perform request
end

Then /^the (response for (test|unhandled) (post|put|get|delete) request) should be returned$/ do |response, type, method|
  last_response.status.to_i.should == response[:status]
  last_response.body.should == response[:body]
end
