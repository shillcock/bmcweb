# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  starts_at   :datetime
#  ends_at     :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string(255)
#  position    :integer
#  workshop_id :integer
#
# Indexes
#
#  index_meetings_on_workshop_id  (workshop_id)
#

class Meeting < ActiveRecord::Base
  belongs_to :workshop
  acts_as_list scope: :workshop
  validates :workshop_id, presence: true
  validates :title, presence: true
  validates :start_date, :start_time, :end_time, presence: true

  alias_attribute :meeting_number, :position

  scope :active, -> { where("date(?) BETWEEN start_date AND end_date", Date.current) }
  scope :upcoming, -> { where("start_date >= ?", Date.current) }
  scope :past, -> { where("end_date <= ?", Date.current) }

  def short_title
    "#{workshop.name} - M#{meeting_number}"
  end
end

