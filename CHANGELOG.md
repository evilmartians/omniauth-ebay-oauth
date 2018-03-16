# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

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


[0.2.0]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/evilmartians/omniauth-ebay-oauth/compare/5213dada5fec8df5da551daf763b6acc84ec7330...v0.1.0
