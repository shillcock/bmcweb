include Warden::Test::Helpers
Warden.test_mode!

feature "User profile edit page", :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario "user changes profile name and email" do
    user = FactoryGirl.create(:user)
    new_user = FactoryGirl.build(:user)

    login_as(user, scope: :user)
    visit edit_my_profile_path

    fill_in "Name", with: new_user.name
    fill_in "Email", with: new_user.email
    click_button "Update Profile"

    expect(page).to have_content I18n.t "my.profile.updated"
    expect(page).to have_content new_user.name
    expect(page).to have_content new_user.email
  end
end

