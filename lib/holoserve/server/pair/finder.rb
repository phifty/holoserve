
class Holoserve::Server::Pair::Finder

  def initialize(configuration, request)
    @configuration, @request = configuration, request
  end

  def pair
    return nil unless layout
    layout.detect do |pair|
      Holoserve::Server::Request::Matcher.new(@request, pair[:request]).match?
    end
  end

  private

  def layout
    @configuration.layout
  end

end
