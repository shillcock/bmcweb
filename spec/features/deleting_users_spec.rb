require 'spec_helper'

feature "Deleting Users" do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    visit root_path(as: admin)
    click_link "Admin"
    click_link "Users"
  end

  scenario "Deleting a user" do
    # save_and_open_page
    # binding.pry
    # click_link user.email
    # click_link "Delete"

    # expect(page).to have_content("User has been deleted.")
  end

  scenario "Users cannot delete themselves" do
    # within_table('users') do
    #   click_link admin.email
    # end

    # click_link "Delete"

    # expect(page).to have_content("You cannot delete yourself!")
  end
end
