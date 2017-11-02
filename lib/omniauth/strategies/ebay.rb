# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # OmniAuth strategy for eBay
    class Ebay < OmniAuth::Strategies::OAuth2
      option :name, :ebay
    end
  end
end
