require 'spec_helper'

feature "Deleting Intro Meetings" do
  let!(:admin) { create(:admin) }
  let!(:intro_meeting) { create(:intro_meeting) }

  before do
    visit root_path(as: admin)
    header_nav.click_link "Admin"
    header_nav.click_link "Intro Meetings"
  end

  scenario "Deleting an intro meeting" do
    find("#intro_meeting_#{intro_meeting.id}").click_link "Delete"

    expect(page).to have_content("Intro meeting has been deleted.")
  end
end
