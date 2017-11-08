# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Ebay do
  let(:options) { {} }

  subject do
    described_class.new(nil, 'ID', 'SECRET', 'RUNAME', options)
  end

  describe '#credentials' do
    let(:token) { 'my_access_token' }
    let(:token_data) do
      {
        'expires_in'                => 7200,
        'refresh_token'             => 'my_refresh_token',
        'refresh_token_expires_in'  => 47_304_000,
        'token_type'                => 'User Access Token'
      }
    end
    let(:access_token) { OAuth2::AccessToken.new(nil, token, token_data) }

    before { allow(subject).to receive(:access_token).and_return(access_token) }

    it 'returns hash with refresh token expiration time', :aggregate_failures do
      expect(subject.credentials).to have_key('refresh_token_expires_in')
      expect(subject.credentials['refresh_token_expires_in']).to eq 47_304_000
    end
  end

  describe '#callback_url' do
    it 'returns correct option' do
      expect(subject.options[:redirect_uri]).to eq('RUNAME')
    end
  end

  describe '#raw_info' do
    let(:user_info) do
      {
        'GetUserResponse' => {
          'User' => {
            'Name' => 'TestUser'
          }
        }
      }
    end

    before do
      allow(OmniAuth::EbayOauth::UserInfoRetriever)
        .to receive(:new)
        .and_return(instance_double(OmniAuth::EbayOauth::UserInfoRetriever, info: user_info))
      allow(subject).to receive(:access_token)
        .and_return(instance_double(OAuth2::AccessToken, token: 'my_access_token'))
    end

    it 'returns instance of UserInfo' do
      expect(subject.raw_info).to be_instance_of(OmniAuth::EbayOauth::UserInfo)
    end
  end

  describe '#setup_phase' do
    before { subject.setup_phase }

    context 'in sandbox environment' do
      let(:options) { { sandbox: true } }

      it 'set correct endpoints', :aggregate_failures do
        expect(subject.options.client_options.authorize_url)
          .to eq('https://signin.sandbox.ebay.com/authorize')
        expect(subject.options.client_options.user_info_url)
          .to eq('https://api.sandbox.ebay.com/ws/api.dll')
        expect(subject.options.client_options.token_url)
          .to eq('https://api.sandbox.ebay.com/identity/v1/oauth2/token')
      end
    end

    context 'in production environment' do
      it 'set correct endpoints', :aggregate_failures do
        expect(subject.options.client_options.authorize_url)
          .to eq('https://signin.ebay.com/authorize')
        expect(subject.options.client_options.user_info_url)
          .to eq('https://api.ebay.com/ws/api.dll')
        expect(subject.options.client_options.token_url)
          .to eq('https://api.ebay.com/identity/v1/oauth2/token')
      end
    end

    context 'when scope is not provided' do
      it 'sets default public scope' do
        expect(subject.options[:scope])
          .to eq('https://api.ebay.com/oauth/api_scope')
      end
    end

    context 'when scope is provided' do
      let(:options) { { scope: 'buy.order.readonly | sell.marketing' } }
      it 'returns correct scopes list' do
        expect(subject.options[:scope])
          .to eq(
            'https://api.ebay.com/oauth/api_scope '\
            'https://api.ebay.com/oauth/api_scope/buy.order.readonly '\
            'https://api.ebay.com/oauth/api_scope/sell.marketing'
          )
      end
    end
  end
end
