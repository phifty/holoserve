
class Holoserve::Pair::Finder

  def initialize(pairs, request)
    @pairs, @request = pairs, request
  end

  def pair
    return nil unless @pairs
    @pairs.each do |id, pair|
      return pair.merge(:id => id) if !Holoserve::Request::Selector.new(@request, pair[:requests]).selection.nil?
    end
    nil
  end

end
