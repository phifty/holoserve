require 'transport'

class Holoserve::Tool::Uploader

  def initialize(filename, http_method, url, options = { })
    @filename, @http_method, @url, @options = filename, http_method, url, options
  end

  def upload
    Transport::HTTP.request @http_method, @url, @options.merge(:headers => headers, :body => body)
  end

  private

  def headers
    { "Content-Type" => "multipart/form-data, boundary=#{boundary}" }
  end

  def body
    "--#{boundary}\r\n" +
    "Content-Disposition: form-data; name=\"file\"; filename=\"#{File.basename(@filename)}\"\r\n" +
    "Content-Type: #{content_type}\r\n" +
    "\r\n" +
    File.read(@filename) +
    "\r\n" +
    "--#{boundary}--\r\n"
  end

  def content_type
    {
      "yaml" => "application/x-yaml",
      "json" => "application/json"
    }[ File.extname(@filename) ] || "text/plain"
  end

  def boundary
    "xxx12345xxx"
  end

end
