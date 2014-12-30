include Warden::Test::Helpers
Warden.test_mode!

feature "User profile page", :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario "user sees own profile" do
    user = FactoryGirl.create(:user)

    login_as(user, scope: :user)
    visit my_profile_path

    expect(page).to have_content "Profile"
    expect(page).to have_content user.name
    expect(page).to have_content user.email
  end
end

