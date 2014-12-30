feature "Sign in", :devise do

  scenario "user can sign in with valid credentials" do
    user = FactoryGirl.create(:user)

    sign_in_with user.email, user.password

    expect(page).to have_content I18n.t "devise.sessions.signed_in"
    user_should_be_signed_in
  end

  scenario "user cannot sign in if not registered" do
    sign_in_with "test@example.com", "password"

    expect(page).to have_content I18n.t "devise.failure.not_found_in_database", authentication_keys: "email"
    user_should_be_signed_out
  end

 scenario "user cannot sign in with wrong email" do
    user = FactoryGirl.create(:user)

    sign_in_with "invalid@email.com", user.password

    expect(page).to have_content I18n.t "devise.failure.not_found_in_database", authentication_keys: "email"
    user_should_be_signed_out
  end

  scenario "user cannot sign in with wrong password" do
    user = FactoryGirl.create(:user)

    sign_in_with user.email, "invalidpass"

    expect(page).to have_content I18n.t "devise.failure.invalid", authentication_keys: "email"
    user_should_be_signed_out
  end
end

