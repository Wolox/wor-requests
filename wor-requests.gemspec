# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wor/requests/version'
require 'date'

Gem::Specification.new do |spec|
  spec.name          = 'wor-requests'
  spec.version       = Wor::Requests::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.date          = Date.today
  spec.authors       = ['draffo']
  spec.email         = ['diego.raffo@wolox.com.ar']

  # TODO: Change summary and description
  spec.summary       = 'Write a short summary, because Rubygems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = 'https://github.com/Wolox/wor-requests'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec)/}) }
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.13'

  spec.add_development_dependency 'byebug', '~> 9.0'
  spec.add_development_dependency 'rubocop', '~> 0.47'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
