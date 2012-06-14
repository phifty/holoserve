
class Holoserve::Request::Selector

  attr_accessor :request

  def initialize(request, request_subsets)
    @request, @request_subsets = request, request_subsets
  end

  def selection
    if Holoserve::Tool::Hash::Matcher.new(@request, @request_subsets[:default]).match?
      @request_subsets.each do |variant, subset|
        next if variant == :default
        return variant if Holoserve::Tool::Hash::Matcher.new(@request, subset).match?
      end
      return :default
    end
    nil
  end

end