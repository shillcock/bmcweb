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
  has_many :meetings
  has_many :lessons, through: :meetings
end
