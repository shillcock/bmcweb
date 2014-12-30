describe Admin::DashboardController, :type => :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  context "guest users" do
    it "are not able to access the index action" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  context "standard users" do
    before { sign_in user }

    it "are not able to access the index action" do
      get :index
      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq("You do not have permission to view that page.")
    end
  end

  context "admin users" do
    before { sign_in admin }

    it "is able to access the index action" do
      get :index
      expect(response).to be_success
    end
  end
end
