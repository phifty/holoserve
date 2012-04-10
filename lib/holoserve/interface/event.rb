require 'goliath/websocket'

class Holoserve::Interface::Event < Goliath::WebSocket

  def on_open(environment)
    self.class.handler = environment["handler"]
  end

  def on_message(environment, message)
    environment.logger.info "MESSAGE #{message}"
  end

  def on_close(environment)
    environment.logger.info("WS CLOSED")
  end

  def on_error(environment, error)
    environment.logger.error error
  end

  def self.handler=(value)
    @handler = value
  end

  def self.send_message(text)
    raise StandardError, "no handler initialised" unless @handler
    @handler.send_text_frame text
  end

end
