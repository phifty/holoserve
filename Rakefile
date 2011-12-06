require 'rubygems'
require 'bundler/setup'

desc "Runs the unicorn interface server."
task :server do
  system "bundle exec unicorn"
end

desc "Runs the shotgun interface server."
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