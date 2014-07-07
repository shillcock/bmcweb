class AddCardFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :card_type, :string
    add_column :users, :card_last4, :string
    add_column :users, :card_expiration, :date
  end
end
