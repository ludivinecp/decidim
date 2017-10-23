# frozen_string_literal: true

module Decidim
  module Messaging
    # The controller to handle the user's chats.
    class ChatsController < Decidim::ApplicationController
      helper Decidim::DatetimeHelper

      def index
        authorize! :index, Chat

        @chats = Chat.accessible_by(current_ability)
      end
    end
  end
end
