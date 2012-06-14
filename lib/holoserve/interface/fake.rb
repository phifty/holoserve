require 'goliath/api'
require 'pp'

class Holoserve::Interface::Fake < Goliath::API

  use Goliath::Rack::Params

  def response(env)
    request = Holoserve::Request::Decomposer.new(env, params).hash
    finder = Holoserve::Pair::Finder.new(pairs, request)
    pair = finder.pair
    if pair
      responses, id, request_variant = pair[:responses], finder.id, finder.variant

      options[:state] = {:request_variant => request_variant}

      selector = Holoserve::Response::Selector.new responses, state, logger
      default_response, selected_responses = selector.default_response, selector.selected_responses
      response_variants = selector.find_variants
      update_state default_response, selected_responses

      history << {:id => id, :request_variant => request_variant, :response_variants => response_variants}

      Holoserve::Interface::Event.send_pair_event id
      logger.info "received handled request with id '#{id}'"

      response = Holoserve::Response::Combiner.new(default_response, selected_responses).response
      Holoserve::Response::Composer.new(response).response_array
    else
      bucket << request
      Holoserve::Interface::Event.send_bucket_event request
      logger.error "received unhandled request\n" + request.pretty_inspect

      not_found
    end
  end

  private

  def update_state(default_response, selected_responses)
    Holoserve::State::Updater.new(state, default_response[:transitions]).perform
    (selected_responses || [ ]).each do |response|
      Holoserve::State::Updater.new(state, response[:transitions]).perform
    end
  end

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
