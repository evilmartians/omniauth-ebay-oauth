# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::EbayOauth::UserInfoRequest do
  subject do
    described_class.new(token, user_info_endpoint: endpoint, read_timeout: 20,
                               request: body)
  end

  let(:endpoint) { 'https://api.com/endpoint' }
  let(:token)    { 'token' }
  let(:body)     { '<>' }

  let(:request_headers) { YAML.load_file('spec/fixtures/request_headers.yml') }
  let(:failure_result)  { File.read('spec/fixtures/result_failure.xml') }
  let(:success_result)  { File.read('spec/fixtures/result_success.xml') }
  let(:user_suspended_result)  { File.read('spec/fixtures/user_suspended.xml') }

  it 'raises error if eBay API request returned non-successful code' do
    stub_request(:post, endpoint)
      .with(body: body, headers: request_headers)
      .to_return(status: 400, body: '', headers: {})
    expect { subject.call }
      .to raise_error(OmniAuth::EbayOauth::FailureResponseCode)
  end

  it 'raises error if eBay API returned non-successful result' do
    stub_request(:post, endpoint)
      .with(body: body, headers: request_headers)
      .to_return(status: 200, body: failure_result, headers: {})
    expect { subject.call }
      .to raise_error(OmniAuth::EbayOauth::FailureResponseResult)
  end

  it 'returns parsed result from eBay in case of all is correct' do
    stub_request(:post, endpoint)
      .with(body: body, headers: request_headers)
      .to_return(status: 200, body: success_result, headers: {})
    expect(subject.call.fetch('GetUserResponse').keys)
      .to eql %w[xmlns Timestamp Ack Version Build User]
  end

  it 'raises error if eBay user is suspended' do
    stub_request(:post, endpoint)
      .with(body: body, headers: request_headers)
      .to_return(status: 200, body: user_suspended_result, headers: {})
    expect { subject.call }
      .to raise_error(OmniAuth::EbayOauth::UserSuspended)
  end
end
