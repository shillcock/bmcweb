# == Schema Information
#
# Table name: workshop_enrollments
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  workshop_id :integer          not null
#  role        :integer          default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

class WorkshopEnrollment < ActiveRecord::Base
  enum role: [ :student, :educator, :presenter ]

  belongs_to :user
  belongs_to :workshop

  scope :students, -> { where(role: roles[:student]) }
  scope :educators, -> { where(role: roles[:educator]) }
  scope :presenters, -> { where(role: roles[:presenter]) }
end
