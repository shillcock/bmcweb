require 'spec_helper'

feature "Editing Users" do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    visit root_path(as: admin)
    header_nav.click_link "Admin"
    header_nav.click_link "Users"
    click_link user.email
    click_link "Edit User"
  end

  scenario "Updating a user's details" do
    fill_in "Email", with: "new_guy@example.com"
    click_button "Update User"

    expect_user_has_been_updated

    expect(page).to have_content("new_guy@example.com")
    expect(page).to_not have_content(user.email)
  end

  scenario "Toggling user's admin ability" do
    expect(page).to have_no_css("#user_#{user.id}", text: "Admin")

    check "Is an admin?"
    click_button "Update User"

    expect_user_has_been_updated

    expect(page).to have_css("#user_#{user.id}", text: user.email)
    expect(page).to have_css("#user_#{user.id}", text: "Admin")
  end

  def expect_user_has_been_updated
    expect(page).to have_content("User has been updated.")
  end
end
