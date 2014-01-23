class Meeting < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :section
end
