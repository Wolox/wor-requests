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
  spec.authors       = ['draffo', 'mishuagopian']
  spec.email         = ['diego.raffo@wolox.com.ar', 'michel.agopian@wolox.com.ar']

  spec.summary       = 'Make external requests in you service objects, with easy logging and error handling!'
  spec.description   = 'Make external requests in you service objects, with easy logging and error handling!'
  spec.homepage      = 'https://github.com/Wolox/wor-requests'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec)/}) }
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.13'
  spec.add_dependency 'railties', '>= 4.1.0', '< 5.2'
end
