require 'json'

module Holoserve::Interface::Control

  autoload :Bucket, File.join(File.dirname(__FILE__), "control", "bucket")
  autoload :History, File.join(File.dirname(__FILE__), "control", "history")
  autoload :Situation, File.join(File.dirname(__FILE__), "control", "situation")

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

end
