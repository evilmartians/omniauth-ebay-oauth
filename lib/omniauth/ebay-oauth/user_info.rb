# frozen_string_literal: true

module OmniAuth
  module EbayOauth
    # Maps user information from Auth'n'auth eBay API to OmniAuth Auth Hash
    # Schema version 1.0
    # https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema
    class UserInfo
      MAPPING = {
        uid: %w[GetUserResponse User EIASToken],
        name: %w[GetUserResponse User RegistrationAddress Name],
        nickname: %w[GetUserResponse User UserID],
        email: %w[GetUserResponse User Email]
      }.freeze

      def initialize(body)
        @body = body
      end

      def uid
        field(:uid, required: true)
      end

      def info
        {
          name: field(:name, required: true),
          email: field(:email),
          nickname: field(:nickname),
          first_name: field(:name).split.first,
          last_name: field(:name).split.last
        }
      end

      def extra
        { raw_info: @body.dig('GetUserResponse', 'User') }
      end

      private

      def field(name, required: false)
        @body.dig(*MAPPING.fetch(name)).tap do |value|
          if value.nil? && required
            raise UnsupportedSchemaError, "Can't find field #{name}"
          end
        end
      end
    end
  end
end
