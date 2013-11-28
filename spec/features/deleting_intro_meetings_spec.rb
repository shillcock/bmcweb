require 'spec_helper'

feature "Deleting Intro Meetings" do
  let!(:admin) { create(:admin) }
  let!(:intro_meeting) { create(:intro_meeting) }

  before do
    visit root_path(as: admin)
    click_link "Admin"
    click_link "Intro Meetings"
  end

  scenario "Deleting an intro meeting" do
    within("#intro_meeting_#{intro_meeting.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("Intro meeting has been deleted.")
  end
end
