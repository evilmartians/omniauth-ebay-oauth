require File.expand_path('../lib/omniauth-ebay-oauth/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "omniauth-ebay-oauth"
  spec.version       = OmniAuth::EbayOAuth2::VERSION
  spec.authors       = ["Andrey Paderin", "Andrey Novikov"]
  spec.email         = ["paderinandrey2011@gmail.com", "envek@envek.name"]

  spec.summary       = %q{A Ebay OAuth2 strategy for OmniAuth}
  spec.description   = %q{A Ebay OAuth2 strategy for OmniAuth}
  spec.homepage      = "https://github.com/Envek/omniauth-ebay-oauth"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth', '~> 1.0'
  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.0'
  spec.add_runtime_dependency 'oauth2', '~> 1.3'

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
