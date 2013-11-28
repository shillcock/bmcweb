require 'spec_helper'

feature "Registering for Intro Meeting" do
  let!(:intro_meeting) { create(:future_intro_meeting) }

  before do
    visit root_path

    meeting_id = "#intro_meeting_#{intro_meeting.id}"
    within(meeting_id) do
      click_link "Register"
    end

    current_path.should eq new_intro_meeting_registration_path(intro_meeting)
  end

  scenario 'Visitor registers for an intro meeting' do
    fill_in "First name", with: "Jon"
    fill_in "Last name", with: "Snow"
    fill_in "Email", with: "jonsnow@example.com"

    click_button 'Register now'

    expect(page).to have_content("Registration has been created.")
  end
end
