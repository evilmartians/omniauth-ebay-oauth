# frozen_string_literal: true

module OmniAuth
  module Strategies
    # OmniAuth strategy for eBay
    class Ebay < OmniAuth::Strategies::OAuth2
      option :production_client_options,
             user_info_endpoint: 'https://api.ebay.com/ws/api.dll',
             token_url: 'https://api.ebay.com/identity/v1/oauth2/token',
             authorize_url: 'https://signin.ebay.com/authorize'
      option :sandbox_client_options,
             user_info_endpoint: 'https://api.sandbox.ebay.com/ws/api.dll',
             token_url: 'https://api.sandbox.ebay.com/identity/v1/oauth2/token',
             authorize_url: 'https://signin.sandbox.ebay.com/authorize'

      option :name, :ebay
      option :callback_url
      option :sandbox, true

      option :authorize_options, %i[scope]
      option :client_options, auth_scheme: :basic_auth

      uid   { user_info.uid }
      info  { user_info.info }
      extra { user_info.extra }

      def setup_phase
        options.client_options.merge!(environment_urls)
        super
      end

      def callback_url
        options.callback_url
      end

      private

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
