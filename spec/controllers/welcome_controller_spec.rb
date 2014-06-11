require 'spec_helper'

describe WelcomeController do
  describe "GET #index" do
    it "populates an array of upcoming meetings" do
      meeting1 = create_intro_meeting_on 1.week.from_now
      meeting2 = create_intro_meeting_on 2.weeks.from_now
      meeting3 = create_intro_meeting_on 3.weeks.from_now
      get :index
      assigns(:upcoming_intro_meetings).should eq [meeting1, meeting2, meeting3]
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #schedule" do
    it "populates an array of sections" do
      section1 = create(:section_with_meetings)
      section2 = create(:section_with_meetings)
      get :schedule
      assigns(:sections).should eq [section1, section2]
    end

    it "renders the :schedule view" do
      get :schedule
      response.should render_template :schedule
    end
  end
end
