require 'spec_helper'

feature "Edit User Profile" do
  let!(:admin) { create(:admin) }
  let!(:profile) { create(:profile) }
  let!(:user) { create(:user, profile: profile) }

  before do
    visit root_path(as: admin)
    click_link "Admin"
    click_link "Users"
    click_link user.email
    click_link "Edit"
  end

  scenario "Updating a user's profile" do
    user.profile = nil
    fill_in "Address1", with: "123 Walnut St."
    fill_in "Address2", with: "PO Box 789"
    fill_in "City", with: "Pacific Grove"
    fill_in "State", with: "CA"
    fill_in "Zip code", with: "93955"
    click_button "Update Profile"

    expect_profile_has_been_updated

    expect(page).to have_content("123 Walnut St.")
    expect(page).to_not have_content(profile.address1)
  end

#    expect(page).to have_css("#user_#{user.id}", text: user.email)
#    expect(page).to have_css("#user_#{user.id}", text: "Admin")

  def expect_profile_has_been_updated
    expect(page).to have_content("Profile was successfully updated.")
  end
end
