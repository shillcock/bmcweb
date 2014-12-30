require 'spec_helper'

feature "Deleting Intro Meetings" do
  let!(:admin) { create(:admin) }
  let!(:intro_meeting) { create(:intro_meeting) }

  before do
    sign_in_with admin.email, admin.password
    visit root_path
    click_link "Admin"
  end

  scenario "Deleting an intro meeting" do
    click_link "Intro Meetings"
    find("#intro_meeting_#{intro_meeting.id}").click_link "Delete"

    expect(page).to have_content("Intro meeting has been deleted.")
  end
end
