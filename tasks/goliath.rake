require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "holoserve"))

namespace :goliath do

  desc "Starts holoserve"
  task :start do
    holoserve = Holoserve.new
    holoserve.start
  end

  desc "Stop holoserve"
  task :stop do
    holoserve = Holoserve.new
    holoserve.stop
  end

  desc "Runs holoserve"
  task :run do
    holoserve = Holoserve.new
    holoserve.run
  end

end