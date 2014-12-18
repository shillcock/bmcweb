module Features
  module SessionHelpers
    def sign_in_with(email, password)
      visit new_user_session_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button I18n.t "user.sessions.new.submit"
    end

    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      fill_in "Password confirmation", with: confirmation
      # click_button I18n.t "user.registrations.new.submit"
      click_button "Sign in"
    end

    def user_should_be_signed_in
      visit root_path
      expect(page).to have_link "Sign out"
    end

    def user_should_be_signed_out
      expect(page).to have_content "Sign in"
    end
  end
end

