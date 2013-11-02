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
    meeting = build(:intro_meeting)
    expect(meeting).to be_valid
  end

  it "is valid and has values equal to those passed in" do
    title = "Free Introductory Meeting"
    start_time = Time.now
    end_time = start_time + 4.hours
    description = "This meeting is open to everyone."

    meeting = build(:intro_meeting, title: title, starts_at: start_time, ends_at: end_time, description: description)

    expect(meeting).to be_valid
    expect(meeting.title).to eq title
    expect(meeting.starts_at).to eq start_time
    expect(meeting.ends_at).to eq end_time
    expect(meeting.description).to eq description
  end

  it "is valid without a description" do
    meeting = build(:intro_meeting, description: nil)
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
