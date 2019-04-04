# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # OmniAuth strategy for eBay
    class EbayOauth < OmniAuth::Strategies::OAuth2
      option :production_client_options,
             user_info_endpoint: 'https://api.ebay.com/ws/api.dll',
             token_url: 'https://api.ebay.com/identity/v1/oauth2/token',
             authorize_url: 'https://auth.ebay.com/oauth2/authorize'
      option :sandbox_client_options,
             user_info_endpoint: 'https://api.sandbox.ebay.com/ws/api.dll',
             token_url: 'https://api.sandbox.ebay.com/identity/v1/oauth2/token',
             authorize_url: 'https://auth.sandbox.ebay.com/oauth2/authorize'

      option :name, :ebay
      option :sandbox, true
      option :callback_url

      option :authorize_options, %i[scope prompt]
      option :client_options, auth_scheme: :basic_auth, read_timeout: 60

      uid          { user_info.uid }
      info         { user_info.info }
      extra        { user_info.extra }
      credentials  { user_credentials }

      def setup_phase
        options.scope = preprocessed_scopes
        options.client_options.merge!(environment_urls)
        super
      end

      def callback_phase
        super
      rescue ::OmniAuth::EbayOauth::UserSuspended => e
        fail!(:user_suspended, e)
      end

      def callback_url
        options.callback_url
      end

      private

      def user_credentials
        self.class.superclass.credentials_stack(self).first.merge(
          'refresh_token_expires_at' =>
            access_token['refresh_token_expires_in'].to_i + Time.now.to_i
        )
      end

      def preprocessed_scopes
        Array(options.scope).join(' ')
      end

      def environment_urls
        if options.sandbox
          options.sandbox_client_options
        else
          options.production_client_options
        end
      end

      def user_info
        @user_info ||=
          OmniAuth::EbayOauth::UserInfo.new(OmniAuth::EbayOauth::UserInfoRequest
          .new(access_token.token, client.options).call)
      end
    end
  end
end
