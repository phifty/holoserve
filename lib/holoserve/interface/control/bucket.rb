require 'goliath/api'

module Holoserve::Interface::Control::Bucket

  class Fetch < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      respond_json bucket
    end

  end

  class Delete < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      bucket.clear
      respond_json_acknowledgement
    end

  end

end
