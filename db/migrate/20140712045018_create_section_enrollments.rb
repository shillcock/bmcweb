class CreateSectionEnrollments < ActiveRecord::Migration
  def change
    create_table :section_enrollments do |t|
      t.integer :user_id, null: false
      t.integer :section_id, null: false
      t.column :role, :integer, default: 0

      t.timestamps
    end

    add_index :section_enrollments, [:section_id, :user_id], unique: true
  end
end
