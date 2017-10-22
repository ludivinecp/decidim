# frozen_string_literal: true

class CreateDecidimMessaging < ActiveRecord::Migration[5.1]
  def change
    create_table :decidim_messaging_chats, &:timestamps

    create_table :decidim_messaging_participations do |t|
      t.references :decidim_chat, null: false
      t.references :decidim_interlocutor, null: false, index: { name: "index_chat_participations_on_interlocutor_id" }

      t.timestamps
    end

    create_table :decidim_messaging_messages do |t|
      t.references :decidim_chat, null: false
      t.references :decidim_sender, null: false

      t.text :body, null: false

      t.timestamps
    end

    create_table :decidim_messaging_receipts do |t|
      t.references :decidim_recipient, null: false

      t.timestamps
    end
  end
end
