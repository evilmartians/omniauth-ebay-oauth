require 'spec_helper'
require 'ostruct'

class FakeStrategy
  include EbayAPI

  def options
    @options ||= begin
      options = OpenStruct.new
      options.runame = 'runame'
      options
    end
  end
end

RSpec.describe EbayAPI do
  subject { FakeStrategy.new }
  let(:good_response) { 'good response' }
  let(:bad_response) { 'bad response' }
  let(:bad_parsed_response) { {} }

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
        expect { subject.user_info }.to raise_error EbayAPI::EbayApiError
      end
    end
  end
end
