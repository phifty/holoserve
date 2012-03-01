require 'goliath/api'

module Holoserve::Interface::Control::Situation

  class Update < Goliath::API
    include Holoserve::Interface::Control::Helper

    use Goliath::Rack::Params

    def response(environment)
      config[:situation] = params[:name]
      logger.info "set situation to #{params[:name]}"
      respond_json_acknowledgement
    end

  end

  class Fetch < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      respond_json :name => config[:situation]
    end

  end

end
