
class Application::Interface::Face

  def call(env)
    [ 200, { "Content-Type" => "text/html" }, [ "test" ] ]
  end

  def configuration
    Application.instance.configuration
  end

end