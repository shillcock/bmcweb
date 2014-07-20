# == Schema Information
#
# Table name: sections
#
#  id          :integer          not null, primary key
#  workshop_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Section < ActiveRecord::Base
  belongs_to :workshop
  has_many :meetings, dependent: :destroy
  has_many :lessons, through: :meetings

  has_many :section_enrollments, dependent: :destroy
  has_many :enrollments, through: :section_enrollments, source: :user

  delegate :bt1?, :bt2?, :short_name, to: :workshop

  scope :bt1, -> { joins(:workshop).merge(Workshop.bt1) }
  scope :bt2, -> { joins(:workshop).merge(Workshop.bt2) }

  def self.active
    where(active: true)
  end

  def self.upcoming
    where('date >= ?', Time.zone.today).order(:date)
  end

  def self.past
    where('date <= ?', Time.zone.today).order(:date)
  end

  def enrolled?(user)
    enrollments.include?(user) if user
  end

  def add_enrollment(user, role: :student)
    return false if enrolled?(user)
    new_enrollment = SectionEnrollment.new(user: user, section: self, role: role)
    new_enrollment.save
  end

  def remove_enrollment(user)
    return unless enrolled?(user)
    enrollments.delete(user)
  end

  def roster
    enrollments.map { |user| Participant.new(user, self) }
  end

  def students
    roster.select { |p| p.student? }
  end

  def educators
    roster.select { |p| p.educator? }
  end

  def start_date
    (meetings.empty? ? Time.zone.now : meetings.first.starts_at).to_date
  end

  def end_date
    (meetings.empty? ? Time.zone.now : meetings.first.starts_at).to_date
  end
end

# SPRING EQUINOX   March     20, 12:57 P.M. EDT
# SUMMER SOLSTICE  June      21,  6:51 A.M. EDT
# FALL EQUINOX     September 22, 10:29 P.M. EDT
# WINTER SOLSTICE  December  21,  6:03 P.M. EST
