
module Holoserve::Request

  autoload :Decomposer, File.join(File.dirname(__FILE__), "request", "decomposer")
  autoload :Router, File.join(File.dirname(__FILE__), "request", "router")
  autoload :Selector, File.join(File.dirname(__FILE__), "request", "selector")

end
