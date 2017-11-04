# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Ebay do
  subject { described_class.new(nil, options) }

  describe '#callback_url' do
    let(:callback_url) { 'https://api.com/callback' }
    let(:options) { { callback_url: callback_url } }
    it 'uses options callback_url' do
      expect(subject.callback_url).to eql(callback_url)
    end
  end

  describe '#options' do
    let(:options) { {} }
    before { subject.setup_phase }

    it 'default mode is sandbox' do
      expect(subject.options.client_options.user_info_endpoint)
        .to eq('https://api.sandbox.ebay.com/ws/api.dll')
    end

    context 'when setup block passed' do
      let(:block) { proc { |_env| (@result ||= 0) && @result += 1 } }
      let(:options) { { setup: block } }

      it 'runs the setup block if passed one' do
        expect(block.call).to eql 2
      end
    end

    context 'sandbox mode' do
      let(:options) { { sandbox: true } }

      it 'has correct eBay sandbox user info endpoint' do
        expect(subject.options.client_options.user_info_endpoint)
          .to eq('https://api.sandbox.ebay.com/ws/api.dll')
      end

      it 'has correct eBay sandbox token url' do
        expect(subject.options.client_options.token_url)
          .to eq('https://api.sandbox.ebay.com/identity/v1/oauth2/token')
      end

      it 'has correct eBay sandbox authorize url' do
        expect(subject.options.client_options.authorize_url)
          .to eq('https://signin.sandbox.ebay.com/authorize')
      end
    end

    context 'production mode' do
      let(:options) { { sandbox: false } }

      it 'has correct eBay production user info endpoint' do
        expect(subject.options.client_options.user_info_endpoint)
          .to eq('https://api.ebay.com/ws/api.dll')
      end

      it 'has correct eBay production token url' do
        expect(subject.options.client_options.token_url)
          .to eq('https://api.ebay.com/identity/v1/oauth2/token')
      end

      it 'has correct eBay production authorize url' do
        expect(subject.options.client_options.authorize_url)
          .to eq('https://signin.ebay.com/authorize')
      end
    end
  end

  describe '#user_info' do
    let(:access_token) { double(:access_token, token: :token) }
    let(:options) { {} }
    let(:user_info) { instance_double(OmniAuth::EbayOauth::UserInfo) }
    let(:request) do
      instance_double(OmniAuth::EbayOauth::UserInfoRequest, call: {})
    end

    before do
      expect(subject).to receive(:access_token).and_return(access_token)
      expect(OmniAuth::EbayOauth::UserInfoRequest)
        .to receive(:new).and_return(request)
      expect(OmniAuth::EbayOauth::UserInfo)
        .to receive(:new).with({}).and_return(user_info)
    end

    it 'returns wrapped user info request' do
      expect(subject.send(:user_info)).to eql(user_info)
    end
  end
end
