require 'spec_helper'

feature "Editing Users" do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    sign_in_with admin.email, admin.password
    visit root_path
    click_link "Admin"

    # click_link "Users"
    # click_link user.email
    # click_link "Edit"
  end

  scenario "Updating a user's email" do
    # fill_in "Email", with: "new_guy@example.com"
    # click_button "Update User"

    # expect_user_has_been_updated

    # expect(page).to have_content("new_guy@example.com")
    # expect(page).to_not have_content(user.email)
  end

  scenario "Updating a user's name" do
    # fill_in "Name", with: "New Guy"
    # click_button "Update User"

    # expect_user_has_been_updated

    # expect(page).to have_content("New Guy")
    # expect(page).to_not have_content(user.name)
  end

  scenario "Toggling user's admin ability" do
    # expect(page).to have_no_css("#user_#{user.id}", text: "Admin")

    # check "Is an admin?"
    # click_button "Update User"

    # expect_user_has_been_updated

    # expect(page).to have_css("#user_#{user.id}", text: user.email)
    # expect(page).to have_css("#user_#{user.id}", text: "Admin")
  end

  def expect_user_has_been_updated
    expect(page).to have_content("User has been updated.")
  end
end
