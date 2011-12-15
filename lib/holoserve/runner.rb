require 'unicorn'

class Holoserve::Runner

  attr_reader :port

  def initialize(options = { })
    @port = options[:port] || 4250
    @layouts_filename = options[:layouts_filename]

    @rackup_options = Unicorn::Configurator::RACKUP
    @rackup_options[:port] = @port
    @rackup_options[:set_listener] = true
    @options = @rackup_options[:options]

    @unicorn = Unicorn::HttpServer.new rack, @options
  end

  def start
    @unicorn.start
    instance.configuration.load_layouts_from_yml @layouts_filename if @layouts_filename
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
    instance.rack
  end

  def instance
    Holoserve.instance
  end

end
