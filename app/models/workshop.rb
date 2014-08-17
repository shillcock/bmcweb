# == Schema Information
#
# Table name: workshops
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#  active      :boolean          default(FALSE)
#

class Workshop < ActiveRecord::Base
  has_many :meetings, -> { order("position ASC") }, dependent: :destroy

  has_many :workshop_enrollments, dependent: :destroy
  has_many :enrollments, through: :workshop_enrollments, source: :user

  has_paper_trail

  validates :name, presence: true
  validates :title, presence: true

  scope :bt1_or_bt2, -> { where(name: ["BT1", "BT2"]) }
  scope :active, -> { joins(:meetings).merge(Meeting.active) }
  scope :upcoming, -> { joins(:meetings).merge(Meeting.upcoming) }
  scope :past, -> { joins(:meetings).merge(Meeting.past) }

  def active?
    (starts_at..ends_at).cover?(Time.zone.today)
  end

  def start_date
    meetings.any? ? meetings.first.starts_at.to_date : Date.new
  end

  def end_date
    meetings.any? ? meetings.last.ends_at.to_date : Date.new
  end

  def roster
    @roster ||= enrollments.map { |user| Participant.new(user, self) }
  end

  def students
    @students ||= roster.select { |p| p.student? }
  end

  def educators
    @educators ||= roster.select { |p| p.educator? }
  end
end

# self.created_on.strftime("%B %d, %Y")
