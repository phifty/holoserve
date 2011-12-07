
class Application::Interface::Fake

  def call(request)
    request_hash = Application::Request::Decomposer.new(request).hash
    pair = Application::Pair::Finder.new(configuration, request_hash).pair
    if pair
      Application::Response::Composer.new(pair[:response]).response_array
    else
      not_found
    end
  end

  private

  def not_found
    [ 404, { "Content-Type" => "text/plain" }, [ "no response found for this request" ] ]
  end

  def layout
    configuration.layout
  end

  def configuration
    Application.instance.configuration
  end

end