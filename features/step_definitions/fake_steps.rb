
When /^a (post|put|get|delete) request is performed$/ do |method|
  @expected_response = case method.to_sym
    when :post
      post "/test"
      { :status => 201, :body => "created" }
    when :put
      put "/test"
      { :status => 200, :body => "updated" }
    when :get
      get "/test"
      { :status => 200, :body => "fetched" }
    when :delete
      delete "/test"
      { :status => 200, :body => "deleted" }
  end
end

When /^a (post|put|get|delete) request is performed with parameter set '([^']+)'$/ do |method, parameter_set|
  @parameters = case parameter_set.to_sym
    when :one
      { :test => "value" }
  end
  @expected_response = case method.to_sym
    when :post
      post "/test", @parameters
      { :status => 201, :body => "created" }
    when :put
      put "/test", @parameters
      { :status => 200, :body => "updated" }
    when :get
      get "/test", @parameters
      { :status => 200, :body => "fetched" }
    when :delete
      delete "/test", @parameters
      { :status => 200, :body => "deleted" }
  end
end

When /^a unhandled (post|put|get|delete) request is performed$/ do |method|
  @expected_response = { :status => 404, :body => "no response found for this request" }
  case method.to_sym
    when :post
      post "/unhandled"
    when :put
      put "/unhandled"
    when :get
      get "/unhandled"
    when :delete
      delete "/unhandled"
  end
end

Then /^the expected response should be returned$/ do
  last_response.status.to_i.should == @expected_response[:status]
  last_response.body.should == @expected_response[:body]
end
