# frozen_string_literal: true

module Decidim
  module Messaging
    class Chat < ApplicationRecord
      has_many :participations, foreign_key: :decidim_chat_id, class_name: "Decidim::Messaging::Participation"
      has_many :interlocutors, through: :participations

      has_many :messages, foreign_key: :decidim_chat_id, class_name: "Decidim::Messaging::Message"
    end
  end
end
