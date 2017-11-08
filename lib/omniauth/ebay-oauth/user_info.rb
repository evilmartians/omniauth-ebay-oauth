# frozen_string_literal: true

module OmniAuth
  module EbayOauth
    class UserInfo # :nodoc:
      def initialize(info)
        @info = info['GetUserResponse']['User']
      end

      def uid
        @info['EIASToken']
      end

      def info
        {
          nickname:   @info['UserID'],
          first_name: name.split.first,
          last_name:  name.split.last,
          email:      @info['Email'],
          phone:      @info['RegistrationAddress']['Phone'],
          country:    @info['RegistrationAddress']['Country']
        }
      end

      def extra
        {
          raw_info: @info
        }
      end

      private

      def name
        @info['RegistrationAddress']['Name']
      end
    end
  end
end
