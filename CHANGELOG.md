# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2021-09-01

### Fixed

 - Ruby 3.0 compatibility (keyword arguments usage)

## [1.0.0] - 2021-04-01

Mark gem as stable

### Changed

 - Relax dependency to [OmniAuth](https://rubygems.org/gems/omniauth) gem to allow using 2.x versions.

   See [OmniAuth 2.0.0 release notes](https://github.com/omniauth/omniauth/releases/tag/v2.0.0) if you want to upgrade to it in your app.

## [0.5.0] - 2019-04-04

### Added

 - Added `prompt` option to allow login under different credentials. @Envek

   See [Getting user consent](https://developer.ebay.com/api-docs/static/oauth-consent-request.html) documentation page for details.

## [0.4.0] - 2018-08-10

### Changed

 - Changed default authentication endpoint. @Envek

   Before: https://signin.ebay.com/authorize – always displays user consent screen “Allow APP_NAME to act on your behalf?”.

   After:  https://auth.ebay.com/oauth2/authorize – doesn't repeatedly ask for user consent.

   I can't find new endpoint address in docs, but it is used in the wild.

## [0.3.0] - 2018-03-23

### Added

 - Handling of suspended users login. @Envek

   Fail authentication with specific code so application can handle it.

## [0.2.0] - 2018-03-16

### Changed

 - Renamed strategy from `ebay` to `ebay_oauth`. @Envek

   This allow to use this strategy simultaneously with old strategies (like [omniauth-ebay](https://github.com/TheGiftsProject/omniauth-ebay) and [ebay_request](https://github.com/gzigzigzeo/ebay_request#omniauth-strategy))

   As eBay allows to have only one OAuth RUName per application keyset while allowing to have many Auth'n'auth RUNames, it may be desirable to use Auth'n'auth for auxilary signins, where obtaining of OAuth tokens is not required.

## [0.1.1] - 2018-01-09

### Fixed

 -  Add missing require to fix gem load errors when this gem is being required from another gem. @Envek


## [0.1.0] - 2017-11-27

 - Initial release: fully working strategy. @ignat-z


[1.0.1]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v0.5.0...v1.0.0
[0.5.0]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/5213dada5fec8df5da551daf763b6acc84ec7330...v0.1.0
