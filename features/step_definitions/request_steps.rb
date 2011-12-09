
Transform /^(test|unhandled) (post|put|get|delete) request$/ do |type, method|
  { "method" => method.upcase, "path" => "/#{type}" }
end

Transform /^parameter set '([^']+)'$/ do |parameter_set_name|
  case parameter_set_name.to_sym
    when :one
      { "parameters" => { "test" => "value" } }
  end
end

Transform /^header set '([^']+)'$/ do |header_set_name|
  case header_set_name.to_sym
    when :one
      { "headers" => { "Test" => "Value" } }
  end
end
