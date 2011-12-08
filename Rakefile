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

namespace :gem do

  desc "Builds the gem"
  task :build do
    system "gem build *.gemspec && mkdir -p pkg/ && mv *.gem pkg/"
  end

  desc "Builds and installs the gem"
  task :install => :build do
    system "gem install pkg/"
  end

end
