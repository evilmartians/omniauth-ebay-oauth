require 'multi_xml'
require 'net/http'

module EbayAPI
  class EbayApiError < StandardError
    attr_accessor :request, :response

    def initialize(message = nil, response = nil)
      super(message)
      @response = response
    end
  end

  EBAY_PRODUCTION_XML_API_URL = 'https://api.ebay.com/ws/api.dll'.freeze
  EBAY_SANDBOX_XML_API_URL = 'https://api.sandbox.ebay.com/ws/api.dll'.freeze
  X_EBAY_API_REQUEST_CONTENT_TYPE = 'text/xml'.freeze
  X_EBAY_API_COMPATIBILITY_LEVEL = '967'.freeze
  X_EBAY_API_CALL_NAME = 'GetUser'.freeze
  GET_USER_REQUEST = File.open(File.join(File.dirname(__FILE__), 'requests', 'get_user.xml'), 'r', &:read)

  def sandbox?
    options.environment == :sandbox
  end

  def url
    api_url = sandbox? ? EBAY_SANDBOX_XML_API_URL : EBAY_PRODUCTION_XML_API_URL
    URI.parse(api_url)
  end

  def user_info
    parsed_response, response = api_get_user
    user = parsed_response && parsed_response['GetUserResponse'] &&
           parsed_response['GetUserResponse']['User']

    raise EbayApiError.new('Failed to retrieve user info', response) unless user

    user
  end

  protected

  def api_get_user
    response = http.request(ebay_request)
    [MultiXml.parse(response.body), response]
  end

  def http
    Net::HTTP.new(url.host, url.port).tap do |http|
      http.use_ssl = true
    end
  end

  def ebay_request
    headers = ebay_request_headers
    Net::HTTP::Post.new(url.path, headers).tap do |request|
      request.body = GET_USER_REQUEST
    end
  end

  def ebay_request_headers
    {
      'X-EBAY-API-CALL-NAME' => X_EBAY_API_CALL_NAME,
      'X-EBAY-API-COMPATIBILITY-LEVEL' => X_EBAY_API_COMPATIBILITY_LEVEL,
      'X-EBAY-API-IAF-TOKEN' => access_token.token,
      'X-EBAY-API-SITEID' => options.siteid.to_s,
      'Content-Type' => X_EBAY_API_REQUEST_CONTENT_TYPE,
      'Content-Length' => GET_USER_REQUEST.length.to_s
    }
  end
end
