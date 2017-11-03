require 'multi_xml'
require 'net/http'

module EbayAPI
  class EbayApiError < StandardError
    attr_accessor :request, :response

    def initialize(message = nil, request = nil, response = nil)
      super(message)
      @request = request
      @response = response
    end
  end

  EBAY_PRODUCTION_XML_API_URL = 'https://api.ebay.com/ws/api.dll'.freeze
  EBAY_SANDBOX_XML_API_URL = 'https://api.sandbox.ebay.com/ws/api.dll'.freeze
  X_EBAY_API_REQUEST_CONTENT_TYPE = 'text/xml'.freeze
  X_EBAY_API_COMPATIBILITY_LEVEL = '967'.freeze
  X_EBAY_API_CALL_NAME = 'GetUser'.freeze

  def sandbox?
    options.environment == :sandbox
  end

  def api_url
    return EBAY_SANDBOX_XML_API_URL if sandbox?
    EBAY_PRODUCTION_XML_API_URL
  end

  def get_user_info
    request = %(
      <?xml version="1.0" encoding="utf-8"?>
      <GetUserRequest xmlns="urn:ebay:apis:eBLBaseComponents">
	      <ErrorLanguage>en_US</ErrorLanguage>
	      <WarningLevel>High</WarningLevel>
      </GetUserRequest>
      )

    parsed_response, response = api(X_EBAY_API_CALL_NAME, request)
    user = parsed_response && parsed_response['GetUserResponse'] &&
           parsed_response['GetUserResponse']['User']

    unless user
      raise EbayApiError.new('Failed to retrieve user info', request, response)
    end

    user
  end

  protected

  def api(call_name, request)
    headers = ebay_request_headers(call_name, request.length.to_s)
    url = URI.parse(api_url)
    req = Net::HTTP::Post.new(url.path, headers)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    response = http.start { |h| h.request(req, request) }.body
    [MultiXml.parse(response), response]
  end

  def ebay_request_headers(call_name, request_length)
    {
      'X-EBAY-API-CALL-NAME' => call_name,
      'X-EBAY-API-COMPATIBILITY-LEVEL' => X_EBAY_API_COMPATIBILITY_LEVEL,
      'X-EBAY-API-IAF-TOKEN' => access_token.token,
      'X-EBAY-API-SITEID' => options.siteid.to_s,
      'Content-Type' => X_EBAY_API_REQUEST_CONTENT_TYPE,
      'Content-Length' => request_length
    }
  end
end
