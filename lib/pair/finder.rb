
class Application::Pair::Finder

  def initialize(configuration, request)
    @configuration, @request = configuration, request
  end

  def pair
    layout.detect do |pair|
      pair[:request] == @request
    end
  end

  private

  def layout
    @configuration.layout
  end

end
