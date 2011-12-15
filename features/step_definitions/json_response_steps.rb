
Transform /^json response for test (get) request$/ do |method|
  { :status => 200, :body => '{"test":"value"}' }
end
