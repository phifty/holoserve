require 'goliath/api'

module Holoserve::Interface::Control::History

  class Fetch < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      respond_json history
    end

  end

  class Delete < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      history.clear
      respond_json_acknowledgement
    end

  end

end
