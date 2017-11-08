# frozen_string_literal: true

module OmniAuth
  module EbayOauth
    DEFAULT_SCOPE = 'https://api.ebay.com/oauth/api_scope'

    class ApiScopeHandler # :nodoc:
      def initialize(scopes)
        @scopes = Array(scopes)
      end

      def scopes_list
        scopes = [DEFAULT_SCOPE]

        unless @scopes.empty?
          @scopes.each { |scope| scopes << "#{DEFAULT_SCOPE}/#{scope.strip}" }
        end

        scopes.join(' ')
      end
    end
  end
end
