require 'goliath/api'
require 'pp'

class Holoserve::Interface::Fake < Goliath::API

  class NoResponseError < StandardError

    attr_reader :id
    attr_reader :request_variant

    def initialize(id, request_variant)
      @id, @request_variant = id, request_variant
    end

  end

  use Goliath::Rack::Params

  def response(env)
    request = Holoserve::Request::Decomposer.new(env, env["parameters"]).hash
    finder = Holoserve::Pair::Finder.new(pairs, request)
    pair = finder.pair
    if pair
      id, request_variant, responses = finder.id, finder.variant, pair[:responses]

      selector = Holoserve::Response::Selector.new responses, state.merge(:request_variant => request_variant), logger
      response_variant = selector.selection

      response = if response_variant == :default
        responses[:default] || { }
      elsif response_variant
        Holoserve::Tool::Merger.new(responses[:default] || { }, responses[response_variant]).result
      else
        raise NoResponseError, id, request_variant
      end
      Holoserve::State::Updater.new(state, response[:transitions]).perform
      history << {:id => id, :request_variant => request_variant, :response_variant => response_variant}

      Holoserve::Interface::Event.send_pair_event id
      logger.info "handled request [#{id}] with request variant [#{request_variant}] and response variant [#{response_variant}]"

      Holoserve::Response::Composer.new(response).response_array
    else
      bucket << request
      Holoserve::Interface::Event.send_bucket_event request
      logger.error "received unhandled request\n" + request.pretty_inspect

      not_found
    end
  rescue NoResponseError => error
    logger.warn "could not select any response for request [#{error.id}] with request variant [#{error.request_variant}]"
  rescue Object => error
    p error
  end

  private

  def not_found
    [ 404, { :"Content-Type" => "text/plain" }, [ "no response found for this request\n" ] ]
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
