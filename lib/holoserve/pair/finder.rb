
class Holoserve::Pair::Finder

  def initialize(configuration, request)
    @configuration, @request = configuration, request
  end

  def pair
    return nil unless pairs
    pairs.each do |name, pair|
      return pair.merge(:name => name) if Holoserve::Request::Matcher.new(@request, pair[:request], fixtures).match?
    end
    nil
  end

  private

  def pairs
    @configuration[:pairs]
  end

  def fixtures
    @configuration[:fixtures]
  end

end
