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
  has_many :meetings, -> { order(position: :asc) }, dependent: :destroy

  has_many :workshop_enrollments, dependent: :destroy
  has_many :enrollments, through: :workshop_enrollments, source: :user

  has_paper_trail

  validates :name, presence: true
  validates :title, presence: true

  scope :bt1, -> { where(name: "BT1") }
  scope :bt2, -> { where(name: "BT2") }
  scope :bt1_or_bt2, -> { where(name: ["BT1", "BT2"]) }
  scope :active, -> { joins(:meetings).merge(Meeting.upcoming).distinct }
  scope :upcoming, -> { joins(:meetings).merge(Meeting.upcoming) }
  scope :past, -> { joins(:meetings).merge(Meeting.past) }

  def self.bt1_or_bt2_active_or_upcoming
    includes(:meetings).bt1_or_bt2.select {|w| w.active? or w.upcoming?}
  end

  def active?
    (start_date..end_date).cover?(Time.zone.today)
  end

  def upcoming?
    Time.zone.today < start_date
  end

  def past?
    Time.zone.today > end_date
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
