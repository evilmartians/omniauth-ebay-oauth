# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth-ebay-oauth/version"

Gem::Specification.new do |spec|
  spec.name          = "omniauth-ebay-oauth"
  spec.version       = OmniAuth::Ebay::VERSION
  spec.authors       = ["Ilya Dolgirev"]
  spec.email         = ["ilya.dolgirev@gmail.com"]

  spec.summary       = %q{OmniAuth Strategy for eBay Apps (for using with eBay REST APIs).}
  spec.homepage      = "https://github.com/Envek/omniauth-ebay-oauth.git"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth-oauth2'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1"
end
