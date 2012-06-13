
class Holoserve::Pair::Finder

  def initialize(pairs, request)
    @pairs, @request = pairs, request
  end

  def pair
    return @pair unless find_pair.nil?
    nil
  end

  def id
    return @id unless find_pair.nil?
    nil
  end

  def variant
    return @variant unless find_pair.nil?
    nil
  end

  private

  def find_pair
    return nil unless @pairs
    @pairs.each do |id, pair|
      @variant = Holoserve::Request::Selector.new(@request, pair[:requests]).selection
      unless @variant.nil?
        @pair = pair
        @id = id
        return ""
      end
    end
    nil
  end

end
