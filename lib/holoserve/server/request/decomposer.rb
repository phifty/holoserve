
class Holoserve::Server::Request::Decomposer

  def initialize(request)
    @request = request
  end

  def hash
    hash = {
      :method => @request["REQUEST_METHOD"],
      :path => @request["PATH_INFO"]
    }
    hash.merge! :headers => headers unless headers.empty?
    hash.merge! :body => body unless body.nil?
    hash.merge! :parameters => parameters unless parameters.empty?
    hash.merge! :oauth => oauth unless oauth.empty?
    hash
  end

  private

  def headers
    headers = { }
    @request.each do |key, value|
      headers[ key.to_sym ] = value unless key =~ /^rack\./
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
    Holoserve::Server::Tool::Hash::KeySymbolizer.new(query_hash.merge(form_hash)).hash
  end

  def query_hash
    @request["rack.request.query_hash"] || { }
  end

  def form_hash
    @request["rack.request.form_hash"] || { }
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

end
