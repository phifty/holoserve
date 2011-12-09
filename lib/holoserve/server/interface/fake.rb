
class Holoserve::Server::Interface::Fake

  def call(env)
    request = Holoserve::Server::Request::Decomposer.new(env).hash
    pair = Holoserve::Server::Pair::Finder.new(configuration, request).pair
    if pair
      history.pair_names << pair[:name] if pair[:name]
      Holoserve::Server::Response::Composer.new(pair[:response]).response_array
    else
      bucket.requests << request
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

  def bucket
    Holoserve::Server.instance.bucket
  end

  def history
    Holoserve::Server.instance.history
  end

  def configuration
    Holoserve::Server.instance.configuration
  end

end
