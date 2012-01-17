
module Holoserve::Interface

  autoload :Control, File.join(File.dirname(__FILE__), "interface", "control")
  autoload :Editor, File.join(File.dirname(__FILE__), "interface", "editor")
  autoload :Fake, File.join(File.dirname(__FILE__), "interface", "fake")

end
