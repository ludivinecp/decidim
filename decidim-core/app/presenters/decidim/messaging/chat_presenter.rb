# frozen_string_literal: true

module Decidim
  module Messaging
    class ChatPresenter < SimpleDelegator
      def self.for_collection(chats)
        chats.map { |chat| new(chat) }
      end

      def interlocutors_for(user)
        interlocutors.where.not(id: user.id).pluck(:name).join(", ")
      end

      def last_message
        return unless messages.any?

        messages.last.body
      end

      def last_update
        return unless messages.any?

        messages.last.created_at
      end
    end
  end
end
