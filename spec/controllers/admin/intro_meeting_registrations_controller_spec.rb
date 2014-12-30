describe Admin::IntroMeetingRegistrationsController, :type => :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:intro_meeting) { create(:intro_meeting) }

  context "standard users" do
    before { sign_in user }

    it "are not able to access the index action" do
      get :index, intro_meeting_id: intro_meeting.id

      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq("You do not have permission to view that page.")
    end
  end

  context "admin users" do
    before { sign_in admin }

    it "is able to access the index action" do
      get :index, intro_meeting_id: intro_meeting.id

      expect(response).to be_success
    end
  end
end
