class AddTrackedFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :last_sign_in_at, :datetime
  end
end
