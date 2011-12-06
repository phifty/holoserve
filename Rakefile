require 'rubygems'
require 'bundler/setup'

desc "Runs the unicorn rack server."
task :server do
  system "bundle exec unicorn"
end

desc "Runs the shotgun rack server."
task :shotgun do
  system "bundle exec shotgun"
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
  end
rescue LoadError
  
end