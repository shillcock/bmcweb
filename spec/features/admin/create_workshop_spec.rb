require "spec_helper"

feature "Creating New Workshop" do
  let(:admin) { create(:admin) }
  #let(:workshop) { create(:workshop) }

  scenario "add new workshop" do
    visit root_path(as: admin)
    click_link("Admin")
    click_link("Workshops")
    click_link("Add new workshop")

    name = "WsName1"
    title = "Workshop Title 1"

    fill_in "Name", with: name
    fill_in "Title", with: title
    click_button "Create Workshop"

    expect(page).to have_content(name)
    expect(page).to have_content(title)
  end
end
