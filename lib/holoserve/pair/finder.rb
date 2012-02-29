
class Holoserve::Pair::Finder

  def initialize(fixtures, pairs, request)
    @fixtures, @pairs, @request = fixtures, pairs, request
  end

  def pair
    return nil unless @pairs
    @pairs.each do |name, pair|
      return pair.merge(:name => name) if Holoserve::Request::Matcher.new(@request, pair[:request], @fixtures).match?
    end
    nil
  end

end
