require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "holoserve"))

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  def start_holoserve
    @holoserve ||= begin
      holoserve = Holoserve.new :fixture_file_pattern => File.expand_path(File.join(File.dirname(__FILE__), "..", "features", "fixtures", "*.yaml")),
                                :pair_file_pattern => File.expand_path(File.join(File.dirname(__FILE__), "..", "features", "pairs", "*.yaml")),
                                :state => { :test => "value" },
                                :log_filename => File.expand_path(File.join(File.dirname(__FILE__), "..", "features", "logs", "test.log"))
      holoserve.start
      holoserve
    end
  end

  def stop_holoserve
    @holoserve.stop if @holoserve
  end

  def run_cucumber(tags = nil)
    start_holoserve

    cucumber_options = tags ? [ "--tags", tags ] : [ ]
    cucumber_options += ENV["CUCUMBER_OPTS"].split(/\s+/) if ENV["CUCUMBER_OPTS"]

    cucumber = Cucumber::Cli::Main.new cucumber_options.flatten.compact
    cucumber.execute!
  ensure
    stop_holoserve
  end

  desc "Run the feature tests"
  task :features do
    run_cucumber
  end

  namespace :features do

    desc "Run the feature tests tagged with @wip"
    task :wip do
      run_cucumber "@wip"
    end

  end

rescue LoadError
  # Ignore
end
