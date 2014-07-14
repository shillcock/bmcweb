class RolifyCreateRoles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:section_enrollments_roles, :id => false) do |t|
      t.references :section_enrollment
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:section_enrollments_roles, [ :section_enrollment_id, :role_id ], name: 'index_section_enrollments_roles_se_id_and_role_id')
  end
end
