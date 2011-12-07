
class Interface::Fake

  def call(request)
    request_hash = Request::Decomposer.new(request).hash
    pair = Pair::Finder.new(configuration, request_hash).pair
    if pair
      Response::Composer.new(pair[:response]).response_array
    else
      bucket.requests << request_hash
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
    Application.instance.bucket
  end

  def configuration
    Application.instance.configuration
  end

end
