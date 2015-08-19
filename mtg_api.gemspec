# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mtg_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'mtg_api'
  spec.version       = MtgApi::VERSION
  spec.authors       = ['Kevin Deisz']
  spec.email         = ['kevin.deisz@gmail.com']

  spec.summary       = 'Ruby integration with mtgapi.com'
  spec.description   = 'Query for cards, sets, and boosters against the mtgapi.com API'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'yard'
end
