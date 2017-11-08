# omniauth-ebay-oauth

OmniAuth Strategy for eBay Apps (for using with eBay REST APIs)

<a href="https://evilmartians.com/?utm_source=omniauth-ebay-oauth&utm_campaign=project_page">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54">
</a>


## Installation

Add gem to your Gemfile:

`gem 'omniauth-ebay-oauth'`

and then run `bundle install`

## Usage

Register your application in [Ebay Developer Program](https://go.developer.ebay.com) to get all the
credentials required below:

```ruby
use OmniAuth::Builder do
  provider :ebay, APP_ID, CERT_ID, RUNAME
end
```

### Using sandbox environment

Production environment is used by default.
If you like to play in sandbox, just pass the proper option:

```ruby
use OmniAuth::Builder do
  provider :ebay, APP_ID, CERT_ID, RUNAME, sandbox: true
end
```

### Using Ebay OAuth Scopes

If you totally omit the `scope` option then by default your token will be assigned to public one
'https://api.ebay.com/oauth/api_scope'

To get access to the specific scopes pass the `scope` option with delimited list of desired scope
names:

```ruby
use OmniAuth::Builder do
  provider :ebay, APP_ID, CERT_ID, RUNAME, scope: 'buy.order.readonly | sell.marketing'
end
```

### Auth Hash Schema

```ruby
{
    provider: "ebay",
    uid: "nY+sHZ2PrBmdj6wVnY+s75FEZ2PrA2dj6wFk4GnC5iFoA6dj6x9nY+seQ==",
    info: {
        username: "john_appleseed",
        first_name: "John",
        last_name: "Appleseed",
        email: "john_appleseed@gmail.com",
        phone: "1000085478",
        country: "US",
        name: "John Appleseed"
    },
    credentials: {
        token: "v^1.1#i^1#f^0#I^3#r^...very long token here",
        refresh_token: "v^1.1#i^1#f^0#I^3#r^1#p^3#t^Ul4xMF8xO...shorter one",
        expires_at: 1510131176,
        expires: true,
        refresh_token_expires_in: 47304000
    },
    extra: {
      # A lot of Ebay info about user. 
    }
}
```

## Development

To run the tests:

`bundle exec rake`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Envek/omniauth-ebay-oauth.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
