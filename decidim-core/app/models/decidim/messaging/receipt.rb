# frozen_string_literal: true

module Decidim
  module Messaging
    class Receipt < ApplicationRecord
      belongs_to :receiver, foreign_key: "decidim_recipient_id", class_name: "Decidim::User"
      belongs_to :message, foreign_key: "decidim_message_id", class_name: "Decidim::Message"

      validates :receiver, :message, presence: true

      scope :recipient, ->(recipient) { where(receiver_id: recipient.id) }
    end
  end
end
