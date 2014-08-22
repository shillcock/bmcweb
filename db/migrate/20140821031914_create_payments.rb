class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true
      t.date :invoice_date
      t.decimal :amount
      t.string :stripe_invoice_id
      t.string :card_last4
      t.boolean :email_sent

      t.timestamps
    end
  end
end
