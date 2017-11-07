# omniauth-ebay-oauth

OmniAuth Strategy for eBay Apps (for using with eBay REST APIs)

<a href="https://evilmartians.com/?utm_source=omniauth-ebay-oauth&utm_campaign=project_page">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54">
</a>


## Installation

Add to your Gemfile:

`gem 'omniauth-ebay-oauth'`

Then `bundle install`.

## Usage

```ruby
use OmniAuth::Builder do
  provider :ebay, CLIENT_ID, CLIENT_SECRET, callback_url: RU_NAME,
    sandbox: false, scope: 'https://api.ebay.com/oauth/api_scope' # redefining additional default options
end
```

Required options:
  - __CLIENT_ID__, __CLIENT_SECRET__ - Your application's [OAuth credentials](<https://developer.ebay.com/api-docs/static/oauth-credentials.html>) for the environment you're targeting.
  - __callback_url__  - Your application's [RuName](<https://developer.ebay.com/api-docs/static/oauth-runame.html>) for the environment you're targeting.

Additional options:
  - __sandbox__ - Are you running your application in [sandbox mode](<https://developer.ebay.com/api-docs/static/sandbox-landing.html>), default __`true`__.
  - __scope__ - A list of [OAuth scopes](<https://developer.ebay.com/api-docs/static/oauth-details.html#scopes>) that provide access to the interfaces you call, default: __`[]`__. If you want change scopes you could pass it as string or as array of scopes like so: `['https://api.ebay.com/oauth/api_scope/sell.marketing.readonly', 'https://api.ebay.com/oauth/api_scope/sell.account.readonly']`
  - __read_timeout__ - Number of seconds to wait for one block to be read for Auth'n'auth eBay API requests, default is 60.
  - \+ all [OmniAuth](<https://github.com/omniauth/omniauth>) supported options, like: `callback_path`, `provider_ignores_state` and so on.

Additional usage information could be found on [OmniAuth README page](<https://github.com/omniauth/omniauth#integrating-omniauth-into-your-application>).

## Minimal working Sinatra application:

```ruby
require 'sinatra'
require 'omniauth-ebay-oauth'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :ebay, ENV['EBAY_CLIENT_ID'], ENV['EBAY_CLIENT_SECRET'],
    callback_url: ENV['EBAY_RU_NAME']
end

get '/' do
  redirect '/auth/ebay'
end

get '/auth/ebay/callback' do
  "Hello, #{request.env['omniauth.auth'].dig('info', 'name')}"
end
```


## Development

To pass your code through the all checks you simply need to run:

```
bundle exec rake
```

Please, keep in mind [OmniAuth Strategy Contribution Guide](<https://github.com/omniauth/omniauth/wiki/Strategy-Contribution-Guide>) and [eBay developers program](<https://developer.ebay.com/api-docs/static/oauth-tokens.html>).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Envek/omniauth-ebay-oauth.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
