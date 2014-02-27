# == Schema Information
#
# Table name: workshops
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Workshop < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :sections, dependent: :destroy
end
