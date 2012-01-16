require 'pp'

class Holoserve::Interface::Fake

  def call(env)
    request = Holoserve::Request::Decomposer.new(env).hash
    pair = Holoserve::Pair::Finder.new(configuration, request).pair
    if pair
      if name = pair[:name]
        history.pair_names << name
        logger.info "received handled request with name '#{name}'"
      end
      responses = pair[:responses]
      response = Holoserve::Tool::Merger.new(responses[:default] || { }, responses[configuration.situation.to_sym] || { }).result
      if response.empty?
        logger.warn "received request #{pair[:name]} with undefined response"
        not_found
      else
        Holoserve::Response::Composer.new(response).response_array
      end
    else
      bucket.requests << request
      logger.error "received unhandled request\n" + request.pretty_inspect
      not_found
    end
  end

  private

  def not_found
    [ 404, { "Content-Type" => "text/plain" }, [ "no response found for this request" ] ]
  end

  def logger
    configuration.logger
  end

  def layout
    configuration.layout
  end

  def bucket
    Holoserve.instance.bucket
  end

  def history
    Holoserve.instance.history
  end

  def configuration
    Holoserve.instance.configuration
  end

end
