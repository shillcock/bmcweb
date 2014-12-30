describe Admin::IntroMeetingsController, :type => :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  context "standard user" do
    { new: :get,
      create: :post,
      destroy: :delete }.each do |action, method|

      it "cannot access the #{action} action" do
        send(method, action, id: create(:intro_meeting))

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You do not have permission to view that page.")
      end
    end
  end
end
