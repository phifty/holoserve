require 'goliath/api'

class Holoserve::Interface < Goliath::API

  autoload :Control, File.join(File.dirname(__FILE__), "interface", "control")
  autoload :Fake, File.join(File.dirname(__FILE__), "interface", "fake")

  attr_accessor :configuration

  map "/*", Fake

end
