# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::EbayOauth::ApiScopeHandler do
  describe '#scopes_list' do
    subject do
      described_class.new(scopes).scopes_list
    end
    context 'when scope option is omitted' do
      let(:scopes) { nil }

      it 'returns default scope' do
        expect(subject).to eq 'https://api.ebay.com/oauth/api_scope'
      end
    end

    context 'when user provides single scope name as string' do
      let(:scopes) { 'sell.inventory' }

      it 'returns default scope and requested one' do
        expect(subject).to eq(
          'https://api.ebay.com/oauth/api_scope '\
          'https://api.ebay.com/oauth/api_scope/sell.inventory'
        )
      end
    end

    context 'when user provides array of scopes names' do
      # let(:scopes) { 'buy.order.readonly | sell.inventory' }
      let(:scopes) { ['buy.order.readonly', 'sell.inventory'] }

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
