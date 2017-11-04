# frozen_string_literal: true

module OmniAuth
  module EbayOauth
    # Receives user information from Auth'n'auth eBay API
    # https://developer.ebay.com/devzone/xml/docs/reference/ebay/GetUser.html
    class UserInfoRequest
      STATUS_PATH  = %w[GetUserResponse Ack].freeze
      SUCCESS_CODE = 'Success'
      USER_REQUEST = File.read(
        File.join(File.dirname(__FILE__), 'get_user.xml')
      )

      TOKEN_HEADER  = 'X-EBAY-API-IAF-TOKEN'
      BASIC_HEADERS = {
        'Content-Type' => 'text/xml',
        'X-EBAY-API-COMPATIBILITY-LEVEL' => 967,
        'X-EBAY-API-SITEID' => 0,
        'X-EBAY-API-CALL-NAME' => 'GetUser'
      }.freeze

      def initialize(access_token, user_info_endpoint:, read_timeout:, **_args)
        @access_token = access_token
        @url = URI(user_info_endpoint)
        @read_timeout = read_timeout
      end

      def call
        MultiXml.parse(
          http
            .request(ebay_request)
            .tap(&ensure_success_code)
            .read_body
        ).tap(&ensure_success_result)
      end

      private

      def ensure_success_code
        lambda { |response|
          unless (200..299).cover?(response.code.to_i)
            raise FailureResponseCode, response
          end
        }
      end

      def ensure_success_result
        lambda { |body|
          unless body.dig(*STATUS_PATH) == SUCCESS_CODE
            raise FailureResponseResult, body
          end
        }
      end

      def http
        Net::HTTP.new(@url.host, @url.port).tap do |http|
          http.read_timeout = @read_timeout
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end

      def ebay_request
        Net::HTTP::Post.new(@url).tap do |request|
          BASIC_HEADERS.merge(TOKEN_HEADER => @access_token)
                       .each { |header, value| request[header] = value }
          request.body = USER_REQUEST
        end
      end
    end
  end
end
