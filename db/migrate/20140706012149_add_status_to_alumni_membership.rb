class AddStatusToAlumniMembership < ActiveRecord::Migration
  def change
    add_column :alumni_memberships, :status, :string, default: "pending"
  end
end
