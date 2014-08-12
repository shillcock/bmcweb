class RenameSectionIdToWorkshopId < ActiveRecord::Migration
  def change
    rename_column :workshop_enrollments, :section_id, :workhshop_id
  end
end
