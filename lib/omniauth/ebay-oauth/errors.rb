# frozen_string_literal: true

module OmniAuth
  module EbayOauth
    class Error < RuntimeError; end
    class FailureResponseCode < Error; end
    class FailureResponseResult < Error; end
    class UnsupportedSchemaError < Error; end
    class UserSuspended < Error; end
  end
end
