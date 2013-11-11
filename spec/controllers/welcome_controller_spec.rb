require 'spec_helper'

describe WelcomeController do
  describe "GET #index" do
    it "populates an array of upcomming meetings" do
      meeting1 = create_intro_meeting_in 1.week
      meeting2 = create_intro_meeting_in 2.week
      meeting3 = create_intro_meeting_in 3.week
      get :index
      assigns(:upcomming_intro_meetings).should eq [meeting1, meeting2, meeting3]
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
end
