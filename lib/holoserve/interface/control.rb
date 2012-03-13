require 'json'

module Holoserve::Interface::Control

  autoload :Bucket, File.join(File.dirname(__FILE__), "control", "bucket")
  autoload :History, File.join(File.dirname(__FILE__), "control", "history")
  autoload :Pair, File.join(File.dirname(__FILE__), "control", "pair")
  autoload :State, File.join(File.dirname(__FILE__), "control", "state")

  module Helper

    def respond_json_acknowledgement
      respond_json :ok => true
    end

    def respond_json(object)
      ok JSON.dump(object), "application/json"
    end

    def ok(content, content_type = "text/plain")
      [ 200, { "Content-Type" => content_type }, [ content ] ]
    end

    def bad_request
      [ 400, { }, [ "bad request" ] ]
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
      config[:state] ||= { }
    end

  end

end
