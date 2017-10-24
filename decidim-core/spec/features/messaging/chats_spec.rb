# frozen_string_literal: true

require "spec_helper"

describe "Chats" do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :confirmed, organization: organization) }
  let(:interlocutor) { create(:user) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim.root_path
  end

  describe "chat list" do
    context "when user has no chats yet" do
      it "links to list of chats from topbar nav" do
        within ".topbar__user__logged" do
          find(".icon--envelope-closed").click
        end

        expect(page).to have_content("You have no chats yet")
      end
    end

    context "when user has chats" do
      let!(:chat) do
        create(
          :chat,
          content: { user => "who wants apples?", interlocutor => "me!" }
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

  describe "chat page" do
    let!(:chat) do
      create(
        :chat,
        content: { user => "who wants apples?", interlocutor => "me!" }
      )
    end

    before do
      within ".topbar__user__logged" do
        find(".icon--envelope-closed").click
      end

      click_link "me!"
    end

    it "shows the full conversation" do
      expect(page).to have_content("who wants apples?")
      expect(page).to have_content("me!")
    end
  end
end
