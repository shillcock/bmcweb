require 'spec_helper'

feature "Creating Users" do
  let!(:admin) { create(:admin) }

  before do
    visit root_path(as: admin)
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end

  scenario "Creating a new user" do
    fill_in "Email", with: "new_user@example.com"
    fill_in "Password", with: "password"
    click_button "Sign up"

    expect(page).to have_content("User has been created.")
  end
end
