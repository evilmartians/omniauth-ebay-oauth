# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::EbayOauth::UserInfoRetriever do
  let(:token)           { '123456789' }
  let(:endpoint)        { 'https://api.example.com/user_info' }
  let(:request_body)    { described_class::USER_INFO_REQUEST_BODY }
  let(:failure_body)    { File.read('spec/fixtures/failure_body.xml') }
  let(:successful_body) { File.read('spec/fixtures/successful_body.xml') }
  let(:headers) do
    { described_class::TOKEN_HEADER => token }.merge!(described_class::USER_INFO_HEADERS)
  end

  subject do
    described_class.new(token, endpoint)
  end

  describe '#info' do
    context 'when response is successful and has successful status' do
      before do
        stub_request(:post, endpoint)
          .with(body: request_body, headers: headers)
          .to_return(status: 200, body: successful_body, headers: {})
      end

      it 'returns user info hash', :aggregate_failures do
        expect(subject.info['GetUserResponse']).to have_key 'User'
      end
    end

    context 'when response is not successful' do
      before do
        stub_request(:post, endpoint)
          .with(body: request_body, headers: headers)
          .to_return(status: 400, body: '', headers: {})
      end

      it 'raises ResponseCodeError' do
        expect { subject.info }.to raise_error(OmniAuth::EbayOauth::ResponseCodeError)
      end
    end

    context 'when response is successful but has failure status' do
      before do
        stub_request(:post, endpoint)
          .with(body: request_body, headers: headers)
          .to_return(status: 200, body: failure_body, headers: {})
      end

      it 'raises ResponseResultError' do
        expect { subject.info }.to raise_error(OmniAuth::EbayOauth::ResponseResultError)
      end
    end
  end
end
