# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mtg_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'mtg_api'
  spec.version       = MtgApi::VERSION
  spec.authors       = ['Kevin Deisz']
  spec.email         = ['kevin.deisz@gmail.com']
  spec.homepage      = 'https://github.com/kddeisz/mtg_api'

  spec.summary       = 'Ruby integration with mtgapi.com'
  spec.description   = 'Query for cards, sets, and boosters against the mtgapi.com API'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'rubocop', '~> 0.33'
  spec.add_development_dependency 'yard', '~> 0.8'
end
