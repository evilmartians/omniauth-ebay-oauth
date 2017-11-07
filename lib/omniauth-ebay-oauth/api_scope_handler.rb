# frozen_string_literal: true

module OmniAuth
  module Ebay
    DEFAULT_SCOPE = 'https://api.ebay.com/oauth/api_scope'.freeze
    SCOPE_DELIMITER = '|'.freeze

    class ApiScopeHandler # :nodoc:
      def initialize(scopes)
        @scopes = scopes || ''
      end

      def scopes_list
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
