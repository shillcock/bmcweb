require "spec_helper"

feature "Creating New Meeting" do
  let(:admin) { create(:admin) }
  let!(:workshop) { create(:workshop) }

  scenario "From workshop" do
    visit root_path(as: admin)
    click_link("Admin")
    click_link("Workshops")
    click_link workshop.title
    click_link("Meetings")
    click_link("Add new meeting")

    fill_in "Title", with: "New Test Section"
    fill_in "Date", with: "2014-09-17 10:00 AM - 2014-09-18 4:00 PM"
    click_button "Create Meeting"

    expect(page).to have_content("Meeting was successfully created")
  end
end
