# frozen_string_literal: true

module Decidim
  module Messaging
    # A class used to find the chats a user is participating in.
    class UserChats < Rectify::Query
      # Syntactic sugar to initialize the class and return the queried objects.
      #
      # user - a User that needs to find which processes can manage
      def self.for(user)
        new(user).query
      end

      def initialize(user)
        @user = user
      end

      def query
        Chat
          .joins(:comments)
          .joins(:participations)
          .where(decidim_messaging_participations: { decidim_interlocutor_id: user.id })
          .distinct
      end

      private

      attr_reader :user
    end
  end
end
