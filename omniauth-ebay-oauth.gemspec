# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/ebay-oauth/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-ebay-oauth'
  spec.version       = OmniAuth::EbayOauth::VERSION
  spec.authors       = ['Ignat Zakrevsky', 'Andrey Novikov']
  spec.email         = ['iezakrevsky@gmail.com', 'envek@envek.name']
  spec.summary       = 'OmniAuth strategy for new eBay OAuth API'
  spec.homepage      = 'https://github.com/evilmartians/omniauth-ebay-oauth'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.3'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.require_paths = ['lib']

  spec.add_dependency 'omniauth', '>= 1.5', '< 3'
  spec.add_dependency 'omniauth-oauth2', '~> 1.4'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '>= 10'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.81.0'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'webmock', '~> 2.1'
end
