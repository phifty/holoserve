
class Holoserve::Interface::Fake

  def call(env)
    request = Holoserve::Request::Decomposer.new(env).hash
    pair = Holoserve::Pair::Finder.new(configuration, request).pair
    if pair
      history.pair_names << pair[:name] if pair[:name]
      Holoserve::Response::Composer.new(pair[:response]).response_array
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
