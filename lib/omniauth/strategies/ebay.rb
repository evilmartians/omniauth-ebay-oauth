# frozen_string_literal: true

module OmniAuth
  module Strategies
    class Ebay < OmniAuth::Strategies::OAuth2 # :nodoc:
      SANDBOX_URLS = {
        user_info_url: 'https://api.sandbox.ebay.com/ws/api.dll',
        authorize_url: 'https://signin.sandbox.ebay.com/authorize',
        token_url:     'https://api.sandbox.ebay.com/identity/v1/oauth2/token'
      }.freeze

      PRODUCTION_URLS = {
        user_info_url: 'https://api.ebay.com/ws/api.dll',
        authorize_url: 'https://signin.ebay.com/authorize',
        token_url:     'https://api.ebay.com/identity/v1/oauth2/token'
      }.freeze

      args %i[client_id client_secret redirect_uri]

      option :sandbox, false
      option :client_options, auth_scheme: :basic_auth

      uid   { raw_info.uid }
      info  { raw_info.info }
      extra { raw_info.extra }

      def credentials
        super.tap do |hash|
          hash.merge!(
            'refresh_token_expires_at' => Time.now.to_i +
              access_token['refresh_token_expires_in'].to_i
          )
        end
      end

      def callback_url
        options.redirect_uri
      end

      def raw_info
        @raw_info ||= OmniAuth::EbayOauth::UserInfo.new(
          OmniAuth::EbayOauth::UserInfoRetriever.new(
            access_token.token,
            options.client_options[:user_info_url]
          ).info
        )
      end

      def setup_phase
        options.client_options.merge!(options.sandbox ? SANDBOX_URLS : PRODUCTION_URLS)
        options[:scope] = OmniAuth::EbayOauth::ApiScopeHandler.new(options[:scope]).scopes_list
        super
      end
    end
  end
end
