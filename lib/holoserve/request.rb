
module Holoserve::Request

  autoload :Decomposer, File.join(File.dirname(__FILE__), "request", "decomposer")
  autoload :Matcher, File.join(File.dirname(__FILE__), "request", "matcher")

end
