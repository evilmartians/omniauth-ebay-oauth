# frozen_string_literal: true

require 'spec_helper'
require 'helpers/user_info_helper'

RSpec.describe OmniAuth::Ebay::UserInfoRetriever do
  include UserInfoHelper

  let(:token) { '123456789' }
  let(:endpoint) { 'https://api.example.com/user_info' }
  let(:request_body) { described_class::USER_INFO_REQUEST_BODY }
  let(:headers) do
    { described_class::TOKEN_HEADER => token }.merge!(described_class::USER_INFO_HEADERS)
  end

  subject do
    described_class.new(token, endpoint)
  end

  describe '#get_info' do
    context 'when response is successful and has successful status' do
      it 'returns user info hash', :aggregate_failures do
        get_successful_response
        expect(subject.get_info['GetUserResponse']).to have_key 'User'
      end
    end

    context 'when response is not successful' do
      it 'raises ResponseCodeError' do
        get_response_with_bad_code
        expect { subject.get_info }.to raise_error(OmniAuth::Ebay::ResponseCodeError)
      end
    end

    context 'when response is successful but has failure status' do
      it 'raises ResponseResultError' do
        get_response_with_bad_status
        expect { subject.get_info }.to raise_error(OmniAuth::Ebay::ResponseResultError)
      end
    end
  end
end
