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

  has_many :registrations, dependent: :destroy, class_name: "IntroMeetingRegistration"

  #scope :past, -> { where('date < ?', Time.now).order(:date) }
  #scope :upcoming, -> { where('date >= ?', Time.now).order(:date) }

  after_initialize do
    self.starts_at ||= Time.parse("19:00")
    self.ends_at ||= Time.parse("21:00")
  end

  def self.upcoming(limit=3)
    where('date >= ?', Time.zone.today).order(:date).limit(limit)
  end

  def self.past
    where('date <= ?', Time.zone.today)
  end

  def time_range
    "#{starts_at.strftime('%l:%M %p')} - #{ends_at.strftime('%l:%M %p')}"
  end

  #strftime(”%l:%M %p”)
end
