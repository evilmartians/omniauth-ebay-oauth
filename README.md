[![Gem Version](https://badge.fury.io/rb/omniauth-ebay-oauth.svg)](https://badge.fury.io/rb/omniauth-ebay-oauth)
[![Build Status](https://travis-ci.org/evilmartians/omniauth-ebay-oauth.svg?branch=master)](https://travis-ci.org/evilmartians/omniauth-ebay-oauth)
[![Cult of Martians](http://cultofmartians.com/assets/badges/badge.svg)](http://cultofmartians.com/tasks/ebay-oauth-signin.html)

# omniauth-ebay-oauth

OmniAuth Strategy for eBay Apps (for using with eBay REST APIs)

<a href="https://evilmartians.com/?utm_source=omniauth-ebay-oauth&utm_campaign=project_page">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54">
</a>

## Preface

> Why do I need it? There are a couple of other gems with OmniAuth strategies for eBay?

eBay has two different authorization methods: Auth'n'auth and OAuth. Technically, they are both uses OAuth2 protocol (just to embrace a little confusion).

This gem implements authorization with OAuth method while currently available gems (like [ebay_request](https://github.com/gzigzigzeo/ebay_request) or [omniauth-ebay](https://github.com/TheGiftsProject/omniauth-ebay)) implements Auth'n'auth.

__What is the difference? Access tokens!__

With Auth'n'auth you will get a single token which you can use to access only old eBay XML APIs (Trading API, etc.)

With OAuth, you will get a pair of access and refresh tokens which can be used to access new eBay REST APIs (Buy API, Sell API, etc.)

However, you can use new OAuth tokens to access old APIs too by providing an access token in HTTP header `X-EBAY-API-IAF-TOKEN`. This is documented in eBay developer program website: [Using OAuth with the eBay traditional APIs](https://developer.ebay.com/api-docs/static/oauth-trad-apis.html#Implemen).

If you plan to use new APIs, you are welcome to use this gem together with [ebay_api](https://github.com/nepalez/ebay_api) client gem for REST APIs.

For old APIs, you can look at [ebay_request](https://github.com/gzigzigzeo/ebay_request) gem (you can configure it to use OAuth tokens).

Now you can read the eBay docs about [REST APIs](https://developer.ebay.com/api-docs/static/ebay-rest-landing.html) and [OAuth](https://developer.ebay.com/api-docs/static/oauth-quick-ref-user-tokens.html) and then proceed to…


## Installation

Add to your Gemfile:

```ruby
gem 'omniauth-ebay-oauth'
```

Then execute:

```sh
bundle install
```


## Usage

```ruby
use OmniAuth::Builder do
  provider :ebay_oauth, CLIENT_ID, CLIENT_SECRET, callback_url: RU_NAME,
    sandbox: false, scope: 'https://api.ebay.com/oauth/api_scope' # redefining additional default options
end
```

Required options:
  - __CLIENT_ID__, __CLIENT_SECRET__ - Your application's [OAuth credentials](<https://developer.ebay.com/api-docs/static/oauth-credentials.html>) for the environment you're targeting.
  - __callback_url__  - Your application's [RuName](<https://developer.ebay.com/api-docs/static/oauth-runame.html>) for the environment you're targeting.

Additional options:
  - __sandbox__ - Are you running your application in [sandbox mode](<https://developer.ebay.com/api-docs/static/sandbox-landing.html>), default __`true`__.
  - __scope__ - A list of [OAuth scopes](<https://developer.ebay.com/api-docs/static/oauth-details.html#scopes>) that provide access to the interfaces you call, default: __`[]`__. If you want change scopes you could pass it as string or as array of scopes like so: `['https://api.ebay.com/oauth/api_scope/sell.marketing.readonly', 'https://api.ebay.com/oauth/api_scope/sell.account.readonly']`
  - __prompt__ - Use value `login` to ask user for login and password even if they're already logged in (useful for switching between multiple accounts). By default is absent.
  - __read_timeout__ - Number of seconds to wait for one block to be read for Auth'n'auth eBay API requests, default is 60.
  - \+ all [OmniAuth](<https://github.com/omniauth/omniauth>) supported options, like: `callback_path`, `provider_ignores_state` and so on.

Additional usage information could be found on [OmniAuth README page](<https://github.com/omniauth/omniauth#integrating-omniauth-into-your-application>).


## Minimal working Sinatra application:

```ruby
require 'sinatra'
require 'omniauth-ebay-oauth'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :ebay_oauth, ENV['EBAY_CLIENT_ID'], ENV['EBAY_CLIENT_SECRET'],
    callback_url: ENV['EBAY_RU_NAME'], name: 'ebay'
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

Bug reports and pull requests are welcome on GitHub at https://github.com/evilmartians/omniauth-ebay-oauth.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
