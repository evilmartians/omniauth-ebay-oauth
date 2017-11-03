# omniauth-ebay-oauth

OmniAuth Strategy for eBay Apps (for using with eBay REST APIs)

<a href="https://evilmartians.com/?utm_source=omniauth-ebay-oauth&utm_campaign=project_page">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54">
</a>


## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-ebay-oauth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-ebay-oauth

## Usage

Register your application with Ebay to receive an API key: https://go.developer.ebay.com/

This is an example that you might put into a Rails initializer at `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ebay, ENV['EBAY_KEY'], ENV['EBAY_SECRET'], ENV['EBAY_RUNAME'], ENV['EBAY_SITE_ID'], ENV['EBAY_ENV']
end
```

You can find out these details by going into your developer account at [eBay Developers Program](https://developer.ebay.com/DevZone/account/)


## Development

Running tests:

```
bundle install
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Envek/omniauth-ebay-oauth.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
