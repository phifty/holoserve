require 'goliath/api'
require 'pp'

class Holoserve::Interface::Fake < Goliath::API

  use Goliath::Rack::Params

  def response(env)
    request = Holoserve::Request::Decomposer.new(env, params).hash
    pair = Holoserve::Pair::Finder.new(pairs, request).pair
    if pair
      id, responses = *pair.values_at(:id, :responses)

      history << id
      logger.info "received handled request with id '#{id}'"

      response = Holoserve::Response::Combiner.new(responses, state, logger).response
      Holoserve::Response::Composer.new(response).response_array
    else
      bucket << request
      logger.error "received unhandled request\n" + request.pretty_inspect

      not_found
    end
  end

  private

  def not_found
    [ 404, { :"Content-Type" => "text/plain" }, [ "no response found for this request" ] ]
  end

  def bucket
    config[:bucket] ||= [ ]
  end

  def history
    config[:history] ||= [ ]
  end

  def pairs
    config[:pairs] ||= options[:pairs]
  end

  def state
    config[:state] ||= options[:state]
  end

end
