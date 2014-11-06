require 'spec_helper'

describe WelcomeController, :type => :controller do
  describe "GET #index" do
    it "populates an array of upcoming meetings" do
      meeting1 = create_intro_meeting_on 1.week.from_now
      meeting2 = create_intro_meeting_on 2.weeks.from_now
      meeting3 = create_intro_meeting_on 3.weeks.from_now
      get :index
      expect(response).to be_successful
      expect(assigns(:upcoming_intro_meetings)).to match_array [meeting1, meeting2, meeting3]
    end

    it "renders the :index view" do
      get :index
      expect(response).to be_successful
      expect(response).to render_template :index
    end
  end

  describe "GET #schedule" do
    # before { pending }
    it "populates an array of sections" do
      section1 = create(:workshop_with_meetings, name: "BT1")
      section2 = create(:workshop_with_meetings, name: "BT2")
      get :schedule
      expect(response).to be_successful
      expect(assigns(:workshops)).to match_array [section1, section2]
    end

    it "only populates an array of bt1 or bt2 sections" do
      section1 = create(:workshop_with_meetings, name: "BT1")
      section2 = create(:workshop_with_meetings, name: "BT8")
      section3 = create(:workshop_with_meetings, name: "BT2")
      section4 = create(:workshop_with_meetings, name: "BT9")
      get :schedule
      expect(response).to be_successful
      expect(assigns(:workshops)).to match_array [section1, section3]
    end

    it "renders the :schedule view" do
      get :schedule
      expect(response).to be_successful
      expect(response).to render_template :schedule
    end
  end
end
