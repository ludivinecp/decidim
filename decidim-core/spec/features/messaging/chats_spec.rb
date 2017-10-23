# frozen_string_literal: true

require "spec_helper"

describe "Chats" do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim.root_path
  end

  context "when user has no chats yet" do
    it "links to list of chats from topbar nav" do
      within ".topbar__user__logged" do
        find(".icon--envelope-closed").click
      end

      expect(page).to have_content("You have no chats yet")
    end
  end

  context "when user has chats" do
    let(:interlocutor) { create(:user) }

    let!(:chat) do
      create(
        :chat,
        content: { user => "who want's apples?", interlocutor => "me!" }
      )
    end

    before do
      within ".topbar__user__logged" do
        find(".icon--envelope-closed").click
      end
    end

    it "shows user's chat list" do
      within ".chats" do
        expect(page).to have_selector(".card--list__item", text: interlocutor.name.upcase)
        expect(page).to have_selector(".card--list__item", text: "me!")
        expect(page).to have_selector(".card--list__item", text: /\d{2}:\d{2}/)
      end
    end
  end
end
