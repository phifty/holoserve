
class Application::Rack::Control

  def initialize(application)
    @application = application
  end

  def call(env)
    [ 200, { "Content-Type" => "text/html" }, [ "one" ] ]
  end
  
end