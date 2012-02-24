
begin
  require 'rdoc'
  require 'rdoc/task'

  Rake::RDocTask.new do |rdoc|
    rdoc.main = "README.rdoc"
    rdoc.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  end
rescue LoadError
end
