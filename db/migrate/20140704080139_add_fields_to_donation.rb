class AddFieldsToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :card_type, :string
    add_column :donations, :card_last4, :string
    add_column :donations, :card_expiration, :date
  end
end
