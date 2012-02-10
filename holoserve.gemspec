# encoding: utf-8

Gem::Specification.new do |specification|
  specification.name              = "holoserve"
  specification.version           = "0.3.1"
  specification.date              = "2012-02-09"

  specification.authors           = [ "Philipp Brüll" ]
  specification.email             = "philipp.bruell@skrill.com"
  specification.homepage          = "http://github.com/skrill/holoserve"
  specification.rubyforge_project = "holoserve"

  specification.summary           = "Tool to fake HTTP APIs."
  specification.description       = "This tool can be used to fake webservice APIs for testing proposals."

  specification.has_rdoc          = true
  specification.files             = [ "README.rdoc", "LICENSE", "Rakefile" ] + Dir["bin/**/*"] + Dir["lib/**/*"] + Dir["spec/**/*"]
  specification.extra_rdoc_files  = [ "README.rdoc" ]
  specification.require_path      = "lib"
  specification.executables       = [ "holoserve" ]

  specification.test_files        = Dir["spec/**/*_spec.rb"]

  specification.add_dependency "rack"
  specification.add_dependency "sinatra"
  specification.add_dependency "unicorn"
  specification.add_dependency "transport"

  specification.add_development_dependency "cucumber"
  specification.add_development_dependency "rspec"
  specification.add_development_dependency "transport"
  specification.add_development_dependency "oauth"
end
