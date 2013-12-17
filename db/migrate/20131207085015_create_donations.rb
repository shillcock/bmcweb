class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :name
      t.string :email
      t.text :comment
      t.integer :amount_cents

      t.string :stripe_token
      t.string :stripe_charge_id
      t.integer :stripe_processing_fee_cents

      t.timestamps
    end
  end
end
