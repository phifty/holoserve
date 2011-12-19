require 'unicorn'
require 'transport'

class Holoserve::Runner

  attr_reader :port

  def initialize(options = { })
    @port = options[:port] || 4250
    @layouts_filename = options[:layouts_filename]
    @layout = options[:layout]

    @rackup_options = Unicorn::Configurator::RACKUP
    @rackup_options[:port] = @port
    @rackup_options[:set_listener] = true
    @options = @rackup_options[:options]

    @unicorn = Unicorn::HttpServer.new rack, @options
  end

  def start
    @unicorn.start
    upload_layouts if @layouts_filename
    set_layout if @layout
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

  def upload_layouts
    Holoserve::Tool::Uploader.new(
      @layouts_filename,
      :post,
      "http://localhost:#{port}/_control/layouts",
      :expected_status_code => 200
    ).upload
    nil
  end

  def set_layout
    Transport::JSON.request :put, "http://localhost:#{port}/_control/layouts/#{@layout}/current", :expected_status_code => 200
    nil
  end

  def rack
    instance.rack
  end

  def instance
    Holoserve.instance
  end

end
