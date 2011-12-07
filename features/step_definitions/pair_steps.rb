
Transform /^(test|unhandled) (post|put|get|delete) pair name$/ do |type, method|
  case [ type.to_sym, method.to_sym ]
    when [ :test, :get ]
      "fetched_test"
    else
      "unknown"
  end
end
