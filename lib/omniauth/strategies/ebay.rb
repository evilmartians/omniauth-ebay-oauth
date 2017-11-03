# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # OmniAuth strategy for eBay
    class Ebay < OmniAuth::Strategies::OAuth2
      option :name, :ebay

      option :callback_url

      option :authorize_options, %i[scope]
      option :client_options,
             auth_scheme: :basic_auth,
             user_info_endpoint: 'https://api.ebay.com/ws/api.dll',
             token_url: 'https://api.ebay.com/identity/v1/oauth2/token',
             authorize_url: 'https://signin.ebay.com/authorize'

      def callback_url
        options.callback_url
      end
    end
  end
end
