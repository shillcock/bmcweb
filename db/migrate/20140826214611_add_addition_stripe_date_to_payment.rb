class AddAdditionStripeDateToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :stripe_customer_id, :string
    add_column :payments, :stripe_charge_id, :string
    add_column :payments, :guid, :string
    add_column :payments, :description, :string
    add_column :payments, :paid, :bool
    rename_column :payments, :invoice_date, :date
    add_index :payments, :guid, unique: true
  end
end
