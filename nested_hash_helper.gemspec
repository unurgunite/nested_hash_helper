# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nested_hash_helper/version'

Gem::Specification.new do |spec|
  spec.name          = 'nested_hash_helper'
  spec.version       = NestedHashHelper::VERSION
  spec.authors       = ['vivek n']
  spec.email         = ['vivekn@freshdesk.com']

  spec.summary       = 'NestedHashHelper to deal with nested Hashes.'
  spec.description   = 'This gem eases your life in dealing with nested Hashes While building Rails apps.'
  spec.homepage      = 'https://github.com/vivek3894/nested_hash_helper'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake', '~> 10.0'
end
