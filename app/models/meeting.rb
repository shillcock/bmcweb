# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  date       :date
#  starts_at  :time
#  ends_at    :time
#  lesson_id  :integer
#  section_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Meeting < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :section

  validate :lesson_id, presence: true
  validate :section_id, presence: true

  delegate :title, to: :lesson

  # def self.ordered
  #   order 'meeting_number ASC'
  # end

  def meeting_number
    lesson.lesson_number
  end

  def short_name
    "BT#{section.workshop.id} - M#{meeting_number}"
  end
end
