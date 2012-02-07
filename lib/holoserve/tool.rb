
module Holoserve::Tool

  autoload :DataPath, File.join(File.dirname(__FILE__), "tool", "data_path")
  autoload :Hash, File.join(File.dirname(__FILE__), "tool", "hash")
  autoload :Merger, File.join(File.dirname(__FILE__), "tool", "merger")
  autoload :Uploader, File.join(File.dirname(__FILE__), "tool", "uploader")

end
