# frozen_string_literal: true

require 'multi_xml'
require 'net/http'

module OmniAuth
  module EbayOauth
    class ResponseCodeError < StandardError; end
    class ResponseResultError < StandardError; end

    class UserInfoRetriever # :nodoc:
      API_COMPATIBILITY_LEVEL = '1031'
      TOKEN_HEADER = 'X-EBAY-API-IAF-TOKEN'

      USER_INFO_REQUEST_BODY = %(
        <?xml version="1.0" encoding="utf-8"?>
        <GetUserRequest xmlns="urn:ebay:apis:eBLBaseComponents">
          <DetailLevel>ReturnAll</DetailLevel>
          <ErrorLanguage>en_US</ErrorLanguage>
          <WarningLevel>High</WarningLevel>
        </GetUserRequest>
      )

      USER_INFO_HEADERS = {
        'X-EBAY-API-SITEID'              => '0',
        'X-EBAY-API-COMPATIBILITY-LEVEL' => API_COMPATIBILITY_LEVEL,
        'X-EBAY-API-CALL-NAME'           => 'GetUser'
      }.freeze

      def initialize(token, endpoint)
        @token = token
        @url = URI(endpoint)
      end

      def info
        response = xml_response
        raise ResponseCodeError, response unless (200..299).cover?(response.code.to_i)

        body = MultiXml.parse(response.read_body)
        raise ResponseResultError, body unless body['GetUserResponse']['Ack'] == 'Success'

        body
      end

      private

      def xml_response
        request = Net::HTTP::Post.new(@url.path,
                                      { TOKEN_HEADER => @token }.merge!(USER_INFO_HEADERS))
        http = Net::HTTP.new(@url.host, @url.port).tap { |h| h.use_ssl = true }
        http.request(request, USER_INFO_REQUEST_BODY)
      end
    end
  end
end
