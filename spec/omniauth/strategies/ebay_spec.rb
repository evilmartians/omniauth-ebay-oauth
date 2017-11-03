require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Ebay do
  subject { OmniAuth::Strategies::Ebay.new(nil, runame: 'runame') }

  describe '#client' do
    it 'has correct Ebay site' do
      expect(subject.client.site).to eq('https://api.ebay.com')
    end

    it 'has correct authorize url' do
      expect(subject.client.options[:authorize_url]).to eq('https://signin.ebay.com/authorize')
    end

    it 'has correct token url' do
      expect(subject.client.options[:token_url]).to eq('identity/v1/oauth2/token')
    end

    it 'has correct auth scheme' do
      expect(subject.client.options[:auth_scheme]).to eq(:basic_auth)
    end
  end

  describe '#callback_url' do
    it 'has the correct callback url' do
      expect(subject.callback_url).to eq('runame')
    end
  end

  describe '#uid' do
    before :each do
      allow(subject).to receive(:raw_info) { { 'EIASToken' => 'uid' } }
    end

    it 'returns the id from raw_info' do
      expect(subject.uid).to eq('uid')
    end
  end

  describe '#info' do
    before :each do
      allow(subject).to receive(:raw_info) { {} }
    end

    context 'and therefore has all the necessary fields' do
      it { expect(subject.info).to have_key :ebay_id }
      it { expect(subject.info).to have_key :email }
      it { expect(subject.info).to have_key :ebay_token }
      it { expect(subject.info).to have_key :full_name }
      it { expect(subject.info).to have_key :country }
      it { expect(subject.info).to have_key :phone }
    end
  end

  describe '#extra' do
    before :each do
      allow(subject).to receive(:raw_info) { { foo: 'bar' } }
    end

    it { expect(subject.extra['raw_info']).to eq(foo: 'bar') }
  end
end
