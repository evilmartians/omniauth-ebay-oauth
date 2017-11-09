require File.expand_path('../lib/omniauth/ebay-oauth/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-ebay-oauth'
  spec.version       = OmniAuth::EbayOAuth::VERSION
  spec.authors       = ['Andrey Paderin', 'Andrey Novikov']
  spec.email         = ['paderinandrey2011@gmail.com', 'envek@envek.name']

  spec.description   = 'A Ebay OAuth2 strategy for OmniAuth'
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/Envek/omniauth-ebay-oauth'
  spec.license       = 'MIT'

  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth', '~> 1.0'
  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.48'
  spec.add_development_dependency 'simplecov', '~> 0.15'
  spec.add_development_dependency 'webmock', '~> 3.1'
end
