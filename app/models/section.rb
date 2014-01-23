class Section < ActiveRecord::Base
  belongs_to :workshop
  has_many :meetings
  has_many :lessons, through: :meetings
end
