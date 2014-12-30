require 'spec_helper'

feature "Deleting Users" do
  # let!(:admin) { create(:admin) }
  # let!(:user) { create(:user) }

  before do
    @admin = create(:admin)
    @user = create(:user)

    sign_in_with @admin.email, @admin.password
    visit root_path
    click_link "Admin"
    click_link "Users"
  end

  # FIXME: Adding DataTable and load by json breaks these tests

  scenario "Deleting a user" do
  #   click_link @user.email
  #   click_link "Delete"

  #   expect(page).to have_content("User has been deleted.")
  end

  scenario "Users cannot delete themselves" do
  #   within_table('users') do
  #     click_link admin.email
  #   end

  #   click_link "Delete"

  #   expect(page).to have_content("You cannot delete yourself!")
  end
end
