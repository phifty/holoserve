
Transform /^(test|unhandled) (post|put|get|delete) request$/ do |type, method|
  { "method" => method.upcase, "path" => "/#{type}" }
end
