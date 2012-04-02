require 'goliath/api'

module Holoserve::Interface::Control::State

  class Update < Goliath::API
    include Holoserve::Interface::Control::Helper

    use Goliath::Rack::Params

    def response(environment)
      state.merge! Holoserve::Tool::Hash::KeySymbolizer.new(params).hash
      logger.info "set state to '#{state.inspect}'"
      respond_json_acknowledgement
    end

  end

  class Fetch < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      respond_json state
    end

  end

  class Delete < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      state.clear
      logger.info "state cleared"
      respond_json_acknowledgement
    end

  end

end
