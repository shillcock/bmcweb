# == Schema Information
#
# Table name: intro_meetings
#
#  id         :integer          not null, primary key
#  date       :date
#  starts_at  :time
#  ends_at    :time
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe IntroMeeting, :type => :model do

  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :starts_at }
  it { is_expected.to validate_presence_of :ends_at }

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
