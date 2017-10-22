# frozen_string_literal: true

module Decidim
  module Messaging
    class Participation < ApplicationRecord
      belongs_to :chat,
                 foreign_key: :decidim_chat_id,
                 class_name: "Decidim::Messaging::Chat",
                 inverse_of: :participations

      belongs_to :interlocutor,
                 foreign_key: :decidim_interlocutor_id,
                 class_name: "Decidim::User"

      validates :chat, :interlocutor, presence: true

      validates :decidim_chat_id, uniqueness: { scope: :decidim_interlocutor_id }
    end
  end
end
