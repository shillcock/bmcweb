class SectionEnrollment < ActiveRecord::Base
  rolify
  belongs_to :user
  belongs_to :section
end
