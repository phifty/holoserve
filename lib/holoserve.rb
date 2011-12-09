
module Holoserve

  autoload :Bucket, File.join(File.dirname(__FILE__), "holoserve", "bucket")
  autoload :Configuration, File.join(File.dirname(__FILE__), "holoserve", "configuration")
  autoload :History, File.join(File.dirname(__FILE__), "holoserve", "history")
  autoload :Interface, File.join(File.dirname(__FILE__), "holoserve", "interface")
  autoload :Pair, File.join(File.dirname(__FILE__), "holoserve", "pair")
  autoload :Request, File.join(File.dirname(__FILE__), "holoserve", "request")
  autoload :Response, File.join(File.dirname(__FILE__), "holoserve", "response")
  autoload :Server, File.join(File.dirname(__FILE__), "holoserve", "server")
  autoload :Tool, File.join(File.dirname(__FILE__), "holoserve", "tool")

end
