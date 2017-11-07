require 'omniauth-oauth2'
require_relative '../../ebay_api'

module OmniAuth
  module Strategies
    class Ebay < OmniAuth::Strategies::OAuth2
      include EbayAPI

      args %i[client_id client_secret runame siteid environment]

      option :name, 'ebay'
      option :client_options, site: 'https://api.ebay.com',
                              authorize_url: 'https://signin.ebay.com/authorize',
                              token_url: 'identity/v1/oauth2/token',
                              auth_scheme: :basic_auth
      option :client_id, nil
      option :client_secret, nil
      option :runame, nil
      option :environment, :production
      option :scope, 'https://api.ebay.com/oauth/api_scope'
      option :siteid, 0

      def callback_url
        options['runame']
      end

      uid { raw_info['EIASToken'] }

      info do
        {
          :nickname => raw_info['UserID'],
          :email => raw_info['Email'],
          :full_name => raw_info['RegistrationAddress'] && raw_info['RegistrationAddress']['Name'],
          :country => raw_info['RegistrationAddress'] && raw_info['RegistrationAddress']['Country'],
          :phone => raw_info['RegistrationAddress'] && raw_info['RegistrationAddress']['Phone']
        }
      end

      extra do
        {
          :raw_info => raw_info
        }
      end

      credentials do
        {
          :refresh_token_expires_in => access_token['refresh_token_expires_in'].to_i
        }
      end

      def raw_info
        @raw_info ||= user_info
      end
    end
  end
end

OmniAuth.config.add_camelization 'ebay', 'Ebay'
