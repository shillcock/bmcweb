class Role < ActiveRecord::Base
  has_and_belongs_to_many :section_enrollments, join_table: :section_enrollments_roles
  belongs_to :resource, polymorphic: true

  scopify
end
