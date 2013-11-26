require 'spec_helper'

describe Admin::IntroMeetingsController do
  let(:user) { create(:user, admin: false) }
  before do
    sign_in_as user
  end

  describe "standard user" do
    { new: :get,
      create: :post }.each do |action, method|

      it "cannot access the new action" do
        send(method, action, id: create(:intro_meeting))

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You do not have permission to view that page.")
      end
    end
  end
end
