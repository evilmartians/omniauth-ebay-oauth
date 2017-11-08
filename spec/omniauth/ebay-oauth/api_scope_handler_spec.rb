# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::EbayOauth::ApiScopeHandler do
  describe '#scopes_list' do
    subject do
      described_class.new(scopes).scopes_list
    end
    context 'when scopes are empty' do
      let(:scopes) { '' }

      it 'returns default scope' do
        expect(subject).to eq 'https://api.ebay.com/oauth/api_scope'
      end
    end

    context 'when user provides list of scopes shortcuts' do
      let(:scopes) { 'buy.order.readonly | sell.inventory' }

      it 'returns list of scopes' do
        expect(subject).to eq(
          'https://api.ebay.com/oauth/api_scope '\
          'https://api.ebay.com/oauth/api_scope/buy.order.readonly '\
          'https://api.ebay.com/oauth/api_scope/sell.inventory'
        )
      end
    end
  end
end
