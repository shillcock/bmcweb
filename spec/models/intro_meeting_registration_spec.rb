# == Schema Information
#
# Table name: intro_meeting_registrations
#
#  id               :integer          not null, primary key
#  first_name       :string(255)
#  last_name        :string(255)
#  email            :string(255)
#  intro_meeting_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_intro_meeting_registrations_on_intro_meeting_id  (intro_meeting_id)
#

require 'spec_helper'

describe IntroMeetingRegistration do
  let(:registration) { create(:intro_meeting_registration) }

  it { should belong_to(:intro_meeting) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }

  it { should respond_to :full_name }
end
