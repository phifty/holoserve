require 'goliath/api'

module Holoserve::Interface::Control::Pair

  class Index < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      respond_json pairs
    end

  end

  class Fetch < Goliath::API
    include Holoserve::Interface::Control::Helper

    def response(environment)
      pair = pairs[ environment["parameters"][:id] ]
      respond_json pair
    end

  end

end
