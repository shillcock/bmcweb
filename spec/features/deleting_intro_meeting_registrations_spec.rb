require 'spec_helper'

feature "Deleting Intro Meeting Registrations" do
  let!(:admin) { create(:admin) }
  let!(:intro_meeting) { create(:future_intro_meeting) }
  let!(:registration) { create(:intro_meeting_registration, intro_meeting: intro_meeting) }

  before do
    visit root_path(as: admin)
    click_link "Admin"
    click_link "Intro Meetings"

    within("#intro_meeting_#{intro_meeting.id}") do
      click_link "Registrations"
    end

    current_path.should eq admin_intro_meeting_registrations_path(intro_meeting)
  end

  scenario "Deleting an intro meeting registration" do
    within("#intro_meeting_registration_#{registration.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("Intro meeting registration has been deleted.")
  end
end
