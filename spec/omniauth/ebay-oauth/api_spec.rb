require 'spec_helper'

RSpec.describe OmniAuth::EbayOAuth::API do
  let(:access_token) { instance_double(OAuth2::AccessToken, token: 'token') }
  let(:good_response) { 'good response' }
  let(:bad_response) { 'bad response' }
  let(:bad_parsed_response) { {} }

  subject { described_class.new(access_token, {}) }

  describe '#get_user_info' do
    let(:good_parsed_response) do
      {
        'GetUserResponse' =>
            {
              'User' => {
                'EIASToken' => 'eiastoken',
                'UserID' => 'userid',
                'Email' => 'email',
                'RegistrationAddress' => {
                  'Name' => 'name',
                  'Country' => 'country',
                  'Phone' => 'phone'
                }
              }
            }
      }
    end

    context 'good response' do
      before :each do
        allow(subject).to receive(:api_get_user) { [good_parsed_response, good_response] }
      end

      it 'should return user info for a good response' do
        expect(subject.user_info).to eq(good_parsed_response['GetUserResponse']['User'])
      end
    end

    context 'bad response' do
      before :each do
        allow(subject).to receive(:api_get_user) { [bad_parsed_response, bad_response] }
      end

      it 'should raise EbayAPIError for a bad response' do
        expect { subject.user_info }.to raise_error OmniAuth::EbayOAuth::API::EbayApiError
      end
    end
  end
end
