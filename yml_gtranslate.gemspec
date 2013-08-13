# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yml_gtranslate/version'

Gem::Specification.new do |gem|
  gem.name          = "yml_gtranslate"
  gem.version       = YmlGtranslate::VERSION
  gem.authors       = ["Stefan Mikula"]
  gem.email         = ["stef.mikula@gmail.com"]
  gem.description   = %q{Uses Google Translate service to translate your *.yml files in your Rails projects. Handy to get your localizations started fast.}
  gem.summary       = %q{Translates your *.yml locale files using Google Translate (no GT API).}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_runtime_dependency 'ya2yaml'
  gem.add_runtime_dependency 'json'

  
  

end
