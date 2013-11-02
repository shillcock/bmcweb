# == Schema Information
#
# Table name: intro_meetings
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  starts_at   :datetime
#  ends_at     :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe IntroMeeting do
  it "is valid with title, starts_at and ends_at" do
    expect(create(:intro_meeting)).to be_valid
  end

  it "is valid and has values equal to those passed in" do
    title = "Free Introductory Meeting"
    start_time = Time.now
    end_time = start_time + 4.hours
    description = "This meeting is open to everyone."

    meeting = create(:intro_meeting, title: title, starts_at: start_time, ends_at: end_time, description: description)

    expect(meeting).to be_valid
    expect(meeting.title).to eq title
    expect(meeting.starts_at).to eq start_time
    expect(meeting.ends_at).to eq end_time
    expect(meeting.description).to eq description
  end

  it "is valid without a description" do
    meeting = create(:intro_meeting, description: nil)
    expect(meeting).to be_valid
  end

  it "is invalid without a title" do
    meeting = build(:intro_meeting, title: nil)
    expect(meeting).to have(1).errors_on(:title)
  end

  it "is invalid without a starts_at" do
    meeting = build(:intro_meeting, starts_at: nil)
    expect(meeting).to have(1).errors_on(:starts_at)
  end

  it "is invalid without a ends_at" do
    meeting = build(:intro_meeting, ends_at: nil)
    expect(meeting).to have(1).errors_on(:ends_at)
  end
end

describe IntroMeeting, ".upcomming" do
  it "should list only meetings that haven't happened yet" do
    meeting0 = create_intro_meeting_in -1.week
    meeting1 = create_intro_meeting_in 1.week
    meeting2 = create_intro_meeting_in 2.week
    meeting3 = create_intro_meeting_in 3.week

    upcomming_meetings = [meeting1, meeting2, meeting3]

    expect(IntroMeeting.upcomming).to eq upcomming_meetings
  end
end
