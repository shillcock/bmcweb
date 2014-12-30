feature "Creating Users" do
  let!(:admin) { create(:admin) }

  before do
    sign_in_with admin.email, admin.password
    visit root_path
    click_link "Admin"
  end

  scenario "Creating a new user as an Admin" do
    # click_link "Users"
    # click_link "Add new user"
    # fill_in "Name", with: "New User"
    # fill_in "Email", with: "new_user@example.com"
    # fill_in "Password", with: "password"
    # click_button "Create User"

    # expect(page).to have_content("User has been created.")
  end
end
