class RenameSectionEnrollments < ActiveRecord::Migration
  def change
    rename_table :section_enrollments, :workshop_enrollments
  end
end
