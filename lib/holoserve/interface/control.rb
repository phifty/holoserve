require 'yaml'
require 'json'
require 'goliath/api'

module Holoserve::Interface::Control

  module Helper

    def respond_json_acknowledgement
      respond_json :ok => true
    end

    def respond_json(object)
      ok JSON.dump(object)
    end

    def ok(content)
      logger.info content.inspect
      [ 200, { }, [ content ] ]
    end

    def bad_request
      [ 400, { }, [ "bad request" ] ]
    end

    def pairs
      config[:pairs] ||= options[:pairs]
    end

    def fixtures
      config[:fixtures] ||= options[:fixtures]
    end

    def bucket
      config[:bucket] ||= [ ]
    end

    def history
      config[:history] ||= [ ]
    end

  end

  class UpdateSituation < Goliath::API
    include Helper

    use Goliath::Rack::Params

    def response(environment)
      config[:situation] = params[:name]
      logger.info "set situation to #{params[:name]}"
      respond_json_acknowledgement
    end

  end

  class FetchSituation < Goliath::API
    include Helper

    def response(environment)
      respond_json :name => config[:situation]
    end

  end

  class FetchBucket < Goliath::API
    include Helper

    def response(environment)
      respond_json bucket
    end

  end

  class DestroyBucket < Goliath::API
    include Helper

    def response(environment)
      bucket.clear
      respond_json_acknowledgement
    end

  end

  class FetchHistory < Goliath::API
    include Helper

    def response(environment)
      respond_json history
    end

  end

  class DestroyHistory < Goliath::API
    include Helper

    def response(environment)
      history.clear
      respond_json_acknowledgement
    end

  end

end