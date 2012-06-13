
class Holoserve::Pair::Finder

  def initialize(pairs, request)
    @pairs, @request = pairs, request
  end

  def pair
    return nil unless @pairs
    @pairs.each do |id, pair|
      variant = Holoserve::Request::Selector.new(@request, pair[:requests]).selection
      return pair.merge(:id => id, :variant => variant.to_s) unless variant.nil?
    end
    nil
  end

end
