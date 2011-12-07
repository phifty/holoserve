
When /^the (test (post|put|get|delete) request) is performed$/ do |request, method|
  @expected_response = case method.to_sym
    when :post
      { :status => 201, :body => "created" }
    when :put
      { :status => 200, :body => "updated" }
    when :get
      { :status => 200, :body => "fetched" }
    when :delete
      { :status => 200, :body => "deleted" }
  end
  perform request
end

When /^the (test (post|put|get|delete) request) is performed with parameter set '([^']+)'$/ do |request, method, parameter_set|
  @parameters = case parameter_set.to_sym
    when :one
      { :test => "value" }
  end
  @expected_response = case method.to_sym
    when :post
      { :status => 201, :body => "created" }
    when :put
      { :status => 200, :body => "updated" }
    when :get
      { :status => 200, :body => "fetched" }
    when :delete
      { :status => 200, :body => "deleted" }
  end
  perform request
end

When /^a (unhandled (post|put|get|delete) request) is performed$/ do |request, method|
  @expected_response = { :status => 404, :body => "no response found for this request" }
  perform request
end

Then /^the expected response should be returned$/ do
  last_response.status.to_i.should == @expected_response[:status]
  last_response.body.should == @expected_response[:body]
end
