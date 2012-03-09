
module Holoserve::Response

  autoload :Combiner, File.join(File.dirname(__FILE__), "response", "combiner")
  autoload :Composer, File.join(File.dirname(__FILE__), "response", "composer")
  autoload :Selector, File.join(File.dirname(__FILE__), "response", "selector")

end
