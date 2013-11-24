class IntroMeeting < ActiveRecord::Base
  validates :title, presence: true
  validates :date, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  def self.upcoming(limit=3)
    where('date >= ?', Time.now).order(:date).limit(limit)
  end

  #strftime(”%l:%M %p”)
end
