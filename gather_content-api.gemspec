# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gather_content/version'

Gem::Specification.new do |gem|
  gem.name          = "gather_content-api"
  gem.version       = GatherContent::VERSION
  gem.authors       = ["Barnaby Alter", "Hannan Butt"]
  gem.email         = ["barnaby.alter@nyu.edu", "hab278@nyu.edu"]
  gem.description   = %q{Ruby wrapper for the GatherContent API}
  gem.summary       = %q{Ruby wrapper for the GatherContent API}
  gem.homepage      = "https://github.com/NYULibraries/gather_content-api"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.licenses      = ['MIT']

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_dependency 'rake', '> 10'
  gem.add_dependency 'rest-client', '~> 2'
  gem.add_dependency 'faraday', '~> 0'
end
