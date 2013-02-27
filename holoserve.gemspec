# encoding: utf-8

Gem::Specification.new do |specification|
  specification.name              = "holoserve"
  specification.version           = "0.4.4"
  specification.date              = "2013-02-27"

  specification.authors           = [ "Philipp Brüll", "Maximilian Hoffmann" ]
  specification.email             = "b.phifty@gmail.com"
  specification.homepage          = "http://github.com/phifty/holoserve"
  specification.rubyforge_project = "holoserve"

  specification.summary           = "Tool to fake HTTP APIs."
  specification.description       = "This tool can be used to fake webservice APIs for testing proposals."

  specification.has_rdoc          = true
  specification.files             = [ "README.rdoc", "LICENSE", "Rakefile" ] + Dir["bin/**/*"] + Dir["lib/**/*"] + Dir["spec/**/*"] + Dir["schema/**/*"]
  specification.extra_rdoc_files  = [ "README.rdoc" ]
  specification.require_path      = "lib"
  specification.executables       = [ "holoserve" ]

  specification.test_files        = Dir["spec/**/*_spec.rb"]

  specification.add_dependency "goliath"
  specification.add_dependency "slim"
  specification.add_dependency "sass"
  specification.add_dependency "coffee-script"
  specification.add_dependency "kwalify"

  specification.add_development_dependency "rake"
  specification.add_development_dependency "rdoc"
  specification.add_development_dependency "cucumber"
  specification.add_development_dependency "rspec"
  specification.add_development_dependency "transport"
  specification.add_development_dependency "oauth"
end
