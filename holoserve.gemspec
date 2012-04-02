# encoding: utf-8

Gem::Specification.new do |specification|
  specification.name              = "holoserve"
  specification.version           = "0.4.1"
  specification.date              = "2012-03-13"

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

  specification.add_dependency "goliath"

  specification.add_development_dependency "rake"
  specification.add_development_dependency "rdoc"
  specification.add_development_dependency "cucumber"
  specification.add_development_dependency "rspec"
  specification.add_development_dependency "transport"
  specification.add_development_dependency "oauth"
end
