require 'goliath/api'
require 'goliath/rack/templates'
require 'slim'
require 'sass'
require 'coffee_script'

module Holoserve::Interface::Control::Index

  class Fetch < Goliath::API
    include Goliath::Rack::Templates
    include Holoserve::Interface::Control::Helper

    def response(environment)
      case environment["REQUEST_URI"]
        when "/_control"
          render_slim :index
        when "/_control/stylesheets/screen.css"
          render_scss :screen
        when "/_control/javascripts/all.js"
          render_coffee :all
        else
          not_found
      end
    end

    private

    def render_slim(template)
      ok slim(template, :views => File.join(Holoserve::Interface::ROOT, "views")), "text/html"
    end

    def render_scss(template)
      ok scss(template, :views => File.join(Holoserve::Interface::ROOT, "stylesheets")), "text/css"
    end

    def render_coffee(template)
      ok coffee(template, :views => File.join(Holoserve::Interface::ROOT, "javascripts")), "text/javascript"
    end

  end

end
