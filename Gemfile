source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

group :development do
  gem 'rubocop', '>= 0.48.1'

end

group :test do
  gem 'rack-test'
  gem 'rspec', '~> 3.6.0'
  gem 'simplecov', require: false
  gem 'webmock'
end

# Specify your gem's dependencies in omniauth-ebay-oauth.gemspec
gemspec
