# frozen_string_literal: true

module Decidim
  module Messaging
    class Chat < ApplicationRecord
      include Decidim::Comments::Commentable

      def organization
        nil
      end

      def max_depth
        0
      end

      has_many :participations, foreign_key: :decidim_chat_id, class_name: "Decidim::Messaging::Participation"
      has_many :interlocutors, through: :participations
    end
  end
end
