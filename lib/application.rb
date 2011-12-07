require 'rack/builder'

class Application

  attr_reader :configuration
  attr_reader :bucket
  attr_reader :history
  attr_reader :rack

  def initialize
    initialize_configuration
    initialize_bucket
    initialize_history
    initialize_rack
  end

  private

  def initialize_configuration
    @configuration = Configuration.new
  end

  def initialize_bucket
    @bucket = Bucket.new
  end

  def initialize_history
    @history = History.new
  end

  def initialize_rack
    @rack = Rack::Builder.new do
      use Interface::Control
      run Interface::Fake.new
    end
  end

  def self.instance
    @instance ||= self.new
  end

end
