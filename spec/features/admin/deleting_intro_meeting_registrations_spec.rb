feature "Deleting Intro Meeting Registrations" do
  let!(:admin) { create(:admin) }
  let!(:intro_meeting) { create(:future_intro_meeting) }
  let!(:registration) { create(:intro_meeting_registration, intro_meeting: intro_meeting) }

  before do
    sign_in_with admin.email, admin.password
    visit root_path

    click_link "Admin"
    click_link "Intro Meetings"

    find("#intro_meeting_#{intro_meeting.id}").click_link "Registrations"

    expect(current_path).to match admin_intro_meeting_registrations_path(intro_meeting)
  end

  scenario "Deleting an intro meeting registration" do
    find("#intro_meeting_registration_#{registration.id}").click_link "Delete"

    expect(page).to have_content("Intro meeting registration has been deleted.")
  end
end
