require 'unicorn'

class Holoserve::Server::Runner

  def initialize
    @rackup_options = Unicorn::Configurator::RACKUP
    @unicorn = nil
  end

  def start
    @unicorn = Unicorn::HttpServer.new(rack, @rackup_options[:options]).start
  end

  def join
    return unless @unicorn
    @unicorn.join
  end

  def stop
    return unless @unicorn
    @unicorn.stop
    @unicorn = nil
  end

  def run
    self.start
    self.join
  end

  private

  def rack
    Holoserve::Server.instance.rack
  end

end
