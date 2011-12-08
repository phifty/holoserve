# encoding: utf-8

Gem::Specification.new do |specification|
  specification.name              = "holoserve-server"
  specification.version           = "0.1.2"
  specification.date              = "2011-12-08"

  specification.authors           = [ "Philipp Brüll" ]
  specification.email             = "philipp.bruell@skrill.com"
  specification.homepage          = "http://github.com/skrill/holoserve-server"
  specification.rubyforge_project = "holoserve-server"

  specification.summary           = "Tool to fake HTTP APIs."
  specification.description       = "This tool can be used to fake webservice APIs for testing proposals."

  specification.has_rdoc          = true
  specification.files             = [ "README.rdoc", "Rakefile" ] + Dir["bin/**/*"] + Dir["lib/**/*"] + Dir["spec/**/*"]
  specification.extra_rdoc_files  = [ "README.rdoc" ]
  specification.require_path      = "lib"

  specification.test_files        = Dir["spec/**/*_spec.rb"]

  specification.add_dependency "rack"
  specification.add_dependency "sinatra"
  specification.add_dependency "unicorn"

  specification.add_development_dependency "rack-test"
  specification.add_development_dependency "cucumber"
  specification.add_development_dependency "rspec"
end
