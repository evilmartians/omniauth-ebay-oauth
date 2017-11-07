# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::EbayOauth::UserInfo do
  subject { described_class.new(parsed_body) }

  let(:xml_body) { File.read('spec/fixtures/result_success.xml') }
  let(:parsed_body) { MultiXml.parse(xml_body) }

  context 'when passed invalid schema' do
    let(:parsed_body) { {} }

    it "raises error if can't find required uid" do
      expect { subject.uid }
        .to raise_error(OmniAuth::EbayOauth::UnsupportedSchemaError)
    end

    it "raises error if can't find required name" do
      expect { subject.info }
        .to raise_error(OmniAuth::EbayOauth::UnsupportedSchemaError)
    end
  end

  describe '#uid' do
    let(:uid) { 'nY+sHZ2PrKoij6wVnY+sEZ2PrA2dj6ACmYChC5WDoQydj6x9nY+seQ==' }

    it 'returns user unique identification' do
      expect(subject.uid).to eql uid
    end
  end

  describe '#info' do
    it 'returns user info corresponding to auth schema', :aggregate_failures do
      {
        name: 'Oleg Petrov',
        email: 'olegpetrov@mail.com',
        nickname: 'olegpetrov',
        first_name: 'Oleg',
        last_name: 'Petrov'
      }.each do |key, value|
        expect(subject.info.fetch(key)).to eql(value)
      end
    end
  end

  describe '#extra' do
    it 'returns user additional information', :aggregate_failures do
      expect(subject.extra.keys).to eql %i[raw_info]
      expect(subject.extra[:raw_info].keys)
        .to eql %w[AboutMePage EIASToken Email FeedbackScore
                   UniqueNegativeFeedbackCount UniquePositiveFeedbackCount
                   PositiveFeedbackPercent FeedbackPrivate FeedbackRatingStar
                   IDVerified eBayGoodStanding NewUser RegistrationAddress
                   RegistrationDate Site Status UserID UserIDChanged VATStatus
                   SellerInfo BusinessRole eBayWikiReadOnly MotorsDealer
                   UniqueNeutralFeedbackCount EnterpriseSeller]
    end
  end
end
