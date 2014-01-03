# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nba/version'

Gem::Specification.new do |spec|
  spec.name          = "nba"
  spec.version       = Nba::VERSION
  spec.authors       = ["Larry Lv"]
  spec.email         = ["larrylv1990@gmail.com"]
  spec.summary       = %q{NBA.rb is a Ruby library for retrieving NBA League games, schedules, teams and players.}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'faraday', ['~> 0.8', '< 0.10']
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.9'
  spec.add_runtime_dependency 'json', '~> 1.8'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6.1'

  spec.add_development_dependency "bundler", "~> 1.5"
end
