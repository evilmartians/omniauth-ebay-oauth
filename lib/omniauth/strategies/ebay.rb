require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ebay < OmniAuth::Strategies::OAuth2
      args %i[client_id client_secret runame]

      option :name, 'ebay'
      option :client_options, site: 'https://api.ebay.com',
                              authorize_url: 'https://signin.ebay.com/authorize',
                              token_url: 'identity/v1/oauth2/token',
                              auth_scheme: :basic_auth
      option :client_id, nil
      option :client_secret, nil
      option :runame, nil
      option :environment, :production
      option :siteid, 0

      BASE_SCOPE_URL = 'https://api.ebay.com/oauth/api_scope'

      def authorize_params
        super.tap do |params|
          params[:scope] = scopes(params)
        end
      end

      def callback_url
        options['runame']
      end

      uid { raw_info['EIASToken'] }

      info do
        {
          nickname: raw_info['UserID'],
          email: raw_info['Email'],
          full_name: raw_info['RegistrationAddress'] && raw_info['RegistrationAddress']['Name'],
          country: raw_info['RegistrationAddress'] && raw_info['RegistrationAddress']['Country'],
          phone: raw_info['RegistrationAddress'] && raw_info['RegistrationAddress']['Phone']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      credentials do
        {
          refresh_token_expires_at: access_token['refresh_token_expires_in'].to_i + Time.now.to_i
        }
      end

      def raw_info
        @raw_info ||= OmniAuth::Strategies::EbayAPI.new(access_token, options).user_info
      end

      private

      def scopes(params)
        raw_scopes = params[:scope] || BASE_SCOPE_URL
        scope_list = raw_scopes.map { |s| s =~ %r{^https?://} ? s : "#{BASE_SCOPE_URL}/#{s}" }
        scope_list.join(' ')
      end
    end
  end
end

OmniAuth.config.add_camelization 'ebay', 'Ebay'
