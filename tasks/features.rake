require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "holoserve"))

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features, nil) do |task|
    task.cucumber_opts = "features --format pretty"
  end

  namespace :features do

    desc "Run the feature tests in test environment"
    task :fake do
      holoserve = Holoserve.new :environment => "test"
      begin
        holoserve.start
        Rake::Task["features"].invoke
      ensure
        holoserve.stop
      end
    end

    Cucumber::Rake::Task.new(:wip, nil) do |task|
      task.cucumber_opts = "features --format pretty --tags @wip"
    end

  end

rescue LoadError
end
