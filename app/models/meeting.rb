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
end
