class MonetizePaymentAmount < ActiveRecord::Migration
  def change
    add_column :payments, :amount_cents, :integer
    remove_column :payments, :amount
  end
end
