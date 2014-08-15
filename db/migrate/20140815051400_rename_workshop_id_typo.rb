class RenameWorkshopIdTypo < ActiveRecord::Migration
  def change
    rename_column :workshop_enrollments, :workhshop_id, :workshop_id
  end
end
