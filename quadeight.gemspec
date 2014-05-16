# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quadeight/version'

Gem::Specification.new do |spec|
  spec.name          = 'quadeight'
  spec.version       = Quadeight::VERSION
  spec.authors       = ['Scott Opell']
  spec.email         = ['me@scottopell.com']
  spec.summary       = %q{8track gem. Gets rid of nasty json}
  spec.description   = %q{Wraps all the functionality
                          available in 8tracks json api in a pretty gem}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'pry-rescue'
  spec.add_development_dependency 'pry-stack_explorer'

  spec.add_dependency 'httparty'
  spec.add_dependency 'mp4info'
end
