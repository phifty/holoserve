
module Holoserve::Request

  autoload :Decomposer, File.join(File.dirname(__FILE__), "request", "decomposer")
  autoload :Selector, File.join(File.dirname(__FILE__), "request", "selector")

end
