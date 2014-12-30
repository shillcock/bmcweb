feature "Creating New Workshop" do
  let(:admin) { create(:admin) }

  before do
    sign_in_with admin.email, admin.password
    visit root_path
    click_link "Admin"
  end

  scenario "add new workshop" do
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
