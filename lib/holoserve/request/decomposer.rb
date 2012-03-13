
class Holoserve::Request::Decomposer

  ONLY_HEADERS = [
    "SERVER_SOFTWARE",
    "SERVER_NAME",
    "SERVER_PORT",
    "REMOTE_ADDR",
    "SCRIPT_NAME",
    "CONTENT_TYPE"
  ].freeze unless defined?(ONLY_HEADERS)

  def initialize(request, parameters)
    @request, @parameters = request, parameters
  end

  def hash
    hash = {
      :method => @request["REQUEST_METHOD"],
      :path => @request["REQUEST_PATH"]
    }
    hash[:headers] = headers unless headers.empty?
    hash[:body] = body unless body.nil?
    hash[:parameters] = parameters unless parameters.empty?
    hash[:oauth] = oauth unless oauth.empty?
    hash[:json] = json unless json.empty?
    hash
  end

  private

  def headers
    headers = { }
    @request.each do |key, value|
      headers[ key.to_sym ] = value if ONLY_HEADERS.include?(key) || key =~ /^HTTP_/
    end
    headers
  end

  def body
    @body ||= begin
      body = @request["rack.input"].read
      body && body != "" ? body : nil
    end
  end

  def parameters
    Holoserve::Tool::Hash::KeySymbolizer.new(@parameters).hash
  end

  def oauth
    @oauth ||= begin
      oauth = { }
      http_authorization = @request["HTTP_AUTHORIZATION"]
      if http_authorization && http_authorization =~ /^OAuth/
        http_authorization = http_authorization.sub /^OAuth/, ""
        pairs = http_authorization.split ","
        pairs.each do |pair|
          key, value = *pair.strip.split("=")
          oauth[ key.to_sym ] = value.sub(/^\\"/, "").sub(/\\"$/, "").gsub(/"/, "")
        end
      end
      oauth
    end
  end

  def json
    @json ||= if @request["CONTENT_TYPE"] == "application/json"
      Holoserve::Tool::Hash::KeySymbolizer.new(JSON.parse(@body)).hash
    else
      { }
    end
  end

end
