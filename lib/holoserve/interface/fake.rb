require 'goliath/api'
require 'pp'

class Holoserve::Interface::Fake < Goliath::API

  def response(env)
    p env
    request = Holoserve::Request::Decomposer.new(env).hash
    pair = Holoserve::Pair::Finder.new(configuration, request).pair
    if pair
      if name = pair[:name]
        history << name
        logger.info "received handled request with name '#{name}'"
      end
      response = Holoserve::Response::Combiner.new(pair[:responses], configuration).response
      if response.empty?
        logger.warn "received request #{pair[:name]} with undefined response"
        not_found
      else
        Holoserve::Response::Composer.new(response).response_array
      end
    else
      bucket << request
      logger.error "received unhandled request\n" + request.pretty_inspect
      not_found
    end
  end

  private

  def not_found
    [ 404, { "Content-Type" => "text/plain" }, [ "no response found for this request" ] ]
  end

  def logger
    Holoserve.instance.logger
  end

  def pairs
    configuration[:pairs]
  end

  def bucket
    configuration[:bucket]
  end

  def history
    configuration[:history]
  end

  def configuration
    Holoserve.instance.configuration
  end

end
