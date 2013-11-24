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
