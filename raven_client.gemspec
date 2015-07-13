# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'raven/version'

Gem::Specification.new do |spec|
  spec.name          = 'raven_client'
  spec.version       = Raven::VERSION
  spec.licenses      = ['MIT']
  spec.authors       = ['Indro De']
  spec.email         = ['indro.de@gmail.com']
  spec.summary       = 'Encrypt and decrypt messages client-side.'
  spec.description   = ''
  spec.homepage      = 'http://raven.zenpunch.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['raven']
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'docopt'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
