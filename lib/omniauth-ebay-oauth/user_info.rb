# frozen_string_literal: true

module OmniAuth
  module Ebay
    class UserInfo # :nodoc:
      def initialize(info)
        @info = info['GetUserResponse']['User']
      end

      def uid
        @info['EIASToken']
      end

      def info
        {
          username:   @info['UserID'],
          first_name: name.split.first,
          last_name:  name.split.last,
          email:      @info['Email'],
          phone:      @info['RegistrationAddress']['Phone'],
          country:    @info['RegistrationAddress']['Country']
        }
      end

      def extra
        @info
      end

      private

      def name
        @info['RegistrationAddress']['Name']
      end
    end
  end
end
