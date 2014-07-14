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
    "#{workshop_short_name} - #{meeting_short_name}"
  end

  private
    def workshop_short_name
      "#{section.workshop.short_name}"
    end

    def meeting_short_name
      "M#{meeting_number}"
    end
end
