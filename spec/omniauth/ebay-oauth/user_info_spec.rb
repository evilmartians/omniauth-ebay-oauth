# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::EbayOauth::UserInfo do
  let(:successful_body) { File.read('spec/fixtures/successful_body.xml') }

  subject { described_class.new(MultiXml.parse(successful_body)) }

  describe '#uid' do
    it 'returns correct uid' do
      expect(subject.uid).to eq 'nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6wFk4GnC5iFoA6dj6x32Y+seQ=='
    end
  end

  describe '#info' do
    let(:user_details) do
      {
        nickname:   'john_appleseed',
        first_name: 'John',
        last_name:  'Appleseed',
        email:      'john_appleseed@gmail.com',
        phone:      '1000085478',
        country:    'US'
      }
    end
    it 'returns correct user details' do
      expect(subject.info).to eq user_details
    end
  end

  describe '#extra' do
    it 'returns all user data' do
      expect(subject.extra).to eq(raw_info: subject.instance_variable_get('@info'))
    end
  end
end
