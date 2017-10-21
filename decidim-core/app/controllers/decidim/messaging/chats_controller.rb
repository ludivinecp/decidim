# frozen_string_literal: true

module Decidim
  # The controller to handle the user's chats.
  class ChatsController < Decidim::ApplicationController
    def index
      authorize! :index, :chats
    end
  end
end
