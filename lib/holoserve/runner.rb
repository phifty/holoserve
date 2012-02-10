require 'unicorn'
require 'transport'

class Holoserve::Runner

  attr_reader :port

  def initialize(options = { })
    @port = options[:port] || 4250
    @fixture_file_pattern = options[:fixture_file_pattern]
    @pair_file_pattern = options[:pair_file_pattern]
    @situation = options[:situation]

    @rackup_options = Unicorn::Configurator::RACKUP
    @rackup_options[:port] = @port
    @rackup_options[:set_listener] = true
    @options = @rackup_options[:options]

    @unicorn = Unicorn::HttpServer.new rack, @options
  end

  def start
    @unicorn.start
    upload_fixtures if @fixture_file_pattern
    upload_pairs if @pair_file_pattern
    set_situation if @situation
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

  def upload_fixtures
    Dir[ @fixture_file_pattern ].each do |filename|
      upload_file "http://localhost:#{port}/_control/fixtures", filename
    end
  end

  def upload_pairs
    Dir[ @pair_file_pattern ].each do |filename|
      upload_file "http://localhost:#{port}/_control/pairs", filename
    end
  end

  def upload_file(url, filename)
    format = File.extname(filename).sub(/^\./, "")
    raise ArgumentError, "file extension indicates wrong format '#{format}' (choose yaml or json)" unless [ "yaml", "json" ].include?(format)
    Holoserve::Tool::Uploader.new(filename, :post, url, :expected_status_code => 200).upload
    nil
  end

  def set_situation
    Transport::JSON.request :put,
                            "http://localhost:#{port}/_control/situation",
                            :parameters => { :name => @situation },
                            :expected_status_code => 200
    nil
  end

  def rack
    instance.rack
  end

  def instance
    Holoserve.instance
  end

end
