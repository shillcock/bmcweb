class AddNameToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :name, :string
    add_column :workshops, :active, :boolean, default: false
  end
end
