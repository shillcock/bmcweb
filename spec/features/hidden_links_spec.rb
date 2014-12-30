feature "hidden links" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  context "anonymous users" do
    scenario "cannot see the Admin link" do
      visit root_path
      assert_no_link_for "Admin"
    end
  end

  context "regular users" do
    scenario "cannot see the Admin link" do
      sign_in_with user.email, user.password

      visit root_path
      assert_no_link_for "Admin"
    end
  end
  context "admin users" do
    scenario "can see the Admin link" do
      sign_in_with admin.email, admin.password

      visit root_path
      assert_link_for "Admin"
    end
  end
end
