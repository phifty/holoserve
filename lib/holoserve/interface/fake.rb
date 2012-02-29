require 'goliath/api'
require 'pp'

class Holoserve::Interface::Fake < Goliath::API

  use Goliath::Rack::Params

  def response(env)
    request = Holoserve::Request::Decomposer.new(env, params).hash
    pair = Holoserve::Pair::Finder.new(fixtures, pairs, request).pair
    if pair
      if name = pair[:name]
        history << name
        logger.info "received handled request with name '#{name}'"
      end
      response = Holoserve::Response::Combiner.new(pair[:responses], config).response
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

  def fixtures
    config[:fixtures] ||= options[:fixtures]
  end

  def pairs
    config[:pairs] ||= options[:pairs]
  end

  def bucket
    config[:bucket] ||= [ ]
  end

  def history
    config[:history] ||= [ ]
  end

end
