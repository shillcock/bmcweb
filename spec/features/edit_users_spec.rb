require 'spec_helper'

feature "Editing Users" do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    visit root_path(as: admin)
    click_link "Admin"
    click_link "Users"
    click_link user.email
    click_link "Edit User"
  end

  scenario "Updating a user's deatils" do
    fill_in "Email", with: "new_guy@example.com"
    click_button "Update User"

    expect_user_has_been_updated

    within("#users") do
      expect(page).to have_content("new_guy@example.com")
      expect(page).to_not have_content(user.email)
    end
  end

  scenario "Toggling user's admin ability" do
    check "Is an admin?"
    click_button "Update User"

    expect_user_has_been_updated

    within("#users") do
      expect(page).to have_content("#{user.email} (Admin)")
    end
  end

  def expect_user_has_been_updated
    expect(page).to have_content("User has been updated.")
  end
end
