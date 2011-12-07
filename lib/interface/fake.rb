
class Application::Interface::Fake

  def call(request)
    request_hash = Application::Request::Decomposer.new(request).hash
    pair = Application::Pair::Finder.new(configuration, request_hash).pair
    Application::Response::Composer.new(pair[:response]).response_array
  end

  private

  def layout
    configuration.layout
  end

  def configuration
    Application.instance.configuration
  end

end