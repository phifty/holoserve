
class Holoserve::Pair::Finder

  def initialize(configuration, request)
    @configuration, @request = configuration, request
  end

  def pair
    return nil unless layout
    layout.detect do |pair|
      Holoserve::Request::Matcher.new(@request, pair[:request]).match?
    end
  end

  private

  def layout
    @configuration.layout
  end

end
