# == Schema Information
#
# Table name: intro_meetings
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  date        :date
#  starts_at   :time             default(2000-01-01 03:00:00 UTC)
#  ends_at     :time             default(2000-01-01 05:00:00 UTC)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe IntroMeeting do

  it { should validate_presence_of :title }
  it { should validate_presence_of :date }
  it { should validate_presence_of :starts_at }
  it { should validate_presence_of :ends_at }

  describe ".upcoming" do
    it "should list only meetings that haven't happened yet with limit of 3" do
      meeting0 = create_intro_meeting_on 1.week.ago
      meeting1 = create_intro_meeting_on 1.week.from_now
      meeting2 = create_intro_meeting_on 2.weeks.from_now
      meeting3 = create_intro_meeting_on 3.weeks.from_now
      meeting4 = create_intro_meeting_on 4.weeks.from_now

      upcomming_meetings = [meeting1, meeting2, meeting3]

      expect(IntroMeeting.upcoming).to eq upcomming_meetings
    end
  end
end
