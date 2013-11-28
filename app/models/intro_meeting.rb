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

class IntroMeeting < ActiveRecord::Base
  validates :date, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  has_many :intro_meeting_registrations, dependent: :destroy

  after_initialize do
    self.starts_at ||= Time.parse("19:00")
    self.ends_at ||= Time.parse("21:00")
  end

  def self.upcoming(limit=3)
    where('date >= ?', Time.now).order(:date).limit(limit)
  end

  #strftime(”%l:%M %p”)
end
