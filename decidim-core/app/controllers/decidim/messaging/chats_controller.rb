# frozen_string_literal: true

module Decidim
  module Messaging
    # The controller to handle the user's chats.
    class ChatsController < Decidim::ApplicationController
      layout "decidim/chat"

      helper Decidim::Comments::CommentsHelper
      helper Decidim::DatetimeHelper

      def index
        authorize! :index, Chat

        @chats = Chat.accessible_by(current_ability)
      end

      def show
        @chat = Chat.find(params[:id])

        authorize! :show, @chat
      end
    end
  end
end
