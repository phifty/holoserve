
class Holoserve::Request::Matcher

  def initialize(request, request_subset, fixtures)
    @request = request
    @request_subset = Holoserve::Fixture::Importer.new(request_subset, fixtures).result
  end

  def match?
    match_method? &&
      match_path? &&
      match_headers? &&
      (@request_subset[:json] ? match_json? : match_body?) &&
      match_parameters? &&
      match_oauth?
  end

  private

  def match_method?
    @request_subset[:method] ?
      @request[:method] == @request_subset[:method] :
      true
  end

  def match_path?
    @request_subset[:path] ?
      @request[:path] == @request_subset[:path] :
      true
  end

  def match_headers?
    match = true
    (@request_subset[:headers] || { }).each do |key, value|
      match &&= @request[:headers][key] == value
    end
    match
  end

  def match_body?
    @request_subset[:body] ?
      @request[:body] == @request_subset[:body] :
      true
  end

  def match_parameters?
    match = true
    (@request_subset[:parameters] || { }).each do |key, value|
      match &&= @request[:parameters].is_a?(Hash) && (@request[:parameters][key] == value)
    end
    match
  end

  def match_oauth?
    match = true
    (@request_subset[:oauth] || { }).each do |key, value|
      match &&= @request[:oauth].is_a?(Hash) && (@request[:oauth][key] == value)
    end
    match
  end

  def match_hash? key
    match = true
    (@request_subset[key] || {}).each do |entry|
      match &&= @request[key].is_a?(Hash) && (@request[key][entry[0]] == entry[1])
    end
    match
  end

  def match_json?
    match_hash? :json
  end

end
