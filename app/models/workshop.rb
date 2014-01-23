class Workshop < ActiveRecord::Base
  has_many :lessons
  has_many :sections
end
