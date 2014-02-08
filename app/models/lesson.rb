# == Schema Information
#
# Table name: lessons
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  summary       :text
#  lesson_number :integer
#  workshop_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Lesson < ActiveRecord::Base
  belongs_to :workshop
  has_many :meetings
  has_many :sections, through: :meetings
end
