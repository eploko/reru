# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reru/version'

Gem::Specification.new do |spec|
  spec.name          = 'reru'
  spec.version       = Reru::VERSION
  spec.authors       = ['Andrey Subbotin']
  spec.email         = ['andrey@subbotin.me']
  spec.description   = 'A gem to easily do the Functional Reactive Programming voodoo.'
  spec.summary       = 'A gem to easily do the Functional Reactive Programming voodoo.'
  spec.homepage      = 'http://github.com/eploko/reru'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'colored'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rb-fsevent'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'slop'
  spec.add_development_dependency 'terminal-notifier-guard'
  spec.add_development_dependency 'travis-lint'

  spec.add_runtime_dependency 'activesupport', '~> 4.0.0rc1'
end
