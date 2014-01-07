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

class IntroMeetingRegistration < ActiveRecord::Base
  belongs_to :intro_meeting

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: %r{.+@.+\..+} }
  validates :intro_meeting_id, presence: true
  validates_presence_of :intro_meeting_id

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
