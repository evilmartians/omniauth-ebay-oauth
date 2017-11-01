# frozen_string_literal: true

module OmniAuth
  module Ebay
    DEFAULT_SCOPE = 'https://api.ebay.com/oauth/api_scope'
    SCOPE_DELIMITER = '|'

    class ApiScopeHandler # :nodoc:
      def initialize(scopes)
        @scopes = scopes || ''
      end

      def get_scopes
        scopes = [DEFAULT_SCOPE]

        unless @scopes.empty?
          @scopes.split(SCOPE_DELIMITER).each do |scope|
            scopes << "#{DEFAULT_SCOPE}/#{scope.strip}"
          end
        end

        scopes.join(' ')
      end
    end
  end
end
