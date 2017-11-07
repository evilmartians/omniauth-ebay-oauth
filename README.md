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
  provider :ebay, ENV['EBAY_KEY'], ENV['EBAY_SECRET'], ENV['EBAY_RUNAME']
end
```

You can find out these details by going into your developer account at [eBay Developers Program](https://developer.ebay.com/DevZone/account/)


## Configuration

You can configure several options, which you pass in to the provider method via a hash:
* `scope`: A comma-separated list of permissions you want to request from the user. See your developer account at [eBay Developers Program](https://developer.ebay.com/DevZone/account/) for a full list of available permissions.
Scopes starting with `https://api.ebay.com/oauth/api_scope` do not need that prefix specified.

    ```ruby
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :ebay, ENV['EBAY_KEY'], ENV['EBAY_SECRET'], ENV['EBAY_RUNAME'], scope: "sell.marketing, sell.account.readonly"
    end
    ```

    Defaults to `https://api.ebay.com/oauth/api_scope`

* `environment`: Before you begin running an application in the Production environment, you should fully test the application's features and functionality to make sure it operates in an error-free manner. In addition, you must be certain that it abides by all eBay API usage rules. To help with your testing, eBay provides the Sandbox environment. Use `:sandbox` option for testing your app.

    Defaults to `:production`

* `siteid`: This option is used if the user wants to retrieve category data for another eBay site (other than the one specified in the `X-EBAY-API-SITEID` request header). See [eBay Site ID](https://developer.ebay.com/devzone/merchandising/docs/concepts/siteidtoglobalid.html)

    Defaults to `0`

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
