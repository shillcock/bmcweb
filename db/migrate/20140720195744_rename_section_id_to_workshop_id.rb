class RenameSectionIdToWorkshopId < ActiveRecord::Migration
  def change
    rename_column :workshop_enrollments, :section_id, :workshop_id
  end
end
