
class Holoserve::Request::Matcher

  def initialize(request, request_subset, fixtures)
    @request, @request_subset, @fixtures = request, request_subset, fixtures

    @request_subset_method = @request_subset[:method]
    @request_subset_path = @request_subset[:path]
    @request_subset_headers = build_data @request_subset[:headers]
    @request_subset_body = @request_subset[:body]
    @request_subset_parameters = build_data @request_subset[:parameters]
    @request_subset_oauth = build_data @request_subset[:oauth]
  end

  def match?
    match_method? &&
      match_path? &&
      match_headers? &&
      match_body? &&
      match_parameters? &&
      match_oauth?
  end

  private

  def build_data(outline)
    outline ? Holoserve::Data::Builder.new(outline, @fixtures).data : { }
  end

  def match_method?
    @request_subset_method ?
      @request[:method] == @request_subset_method :
      true
  end

  def match_path?
    @request_subset_path ?
      @request[:path] == @request_subset_path :
      true
  end

  def match_headers?
    match = true
    @request_subset_headers.each do |key, value|
      match &&= @request[:headers][key] == value
    end
    match
  end

  def match_body?
    @request_subset_body ?
      @request[:body] == @request_subset_body :
      true
  end

  def match_parameters?
    match = true
    @request_subset_parameters.each do |key, value|
      match &&= @request[:parameters].is_a?(Hash) && (@request[:parameters][key] == value)
    end
    match
  end

  def match_oauth?
    match = true
    @request_subset_oauth.each do |key, value|
      match &&= @request[:oauth].is_a?(Hash) && (@request[:oauth][key] == value)
    end
    match
  end

end
