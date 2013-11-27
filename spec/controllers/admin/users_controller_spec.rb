require 'spec_helper'

describe Admin::UsersController do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  context "standard users" do
    before { sign_in_as user }

    it "are not able to access the index action" do
      get 'index'

      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq("You do not have permission to view that page.")
    end
  end

  context "admin users" do
    before { sign_in_as admin }

    it "is able to access the index action" do
      get 'index'

      expect(response).to be_success
    end
  end
end
