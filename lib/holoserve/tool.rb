
module Holoserve::Tool

  autoload :Hash, File.join(File.dirname(__FILE__), "tool", "hash")
  autoload :Merger, File.join(File.dirname(__FILE__), "tool", "merger")
  autoload :Uploader, File.join(File.dirname(__FILE__), "tool", "uploader")

end
