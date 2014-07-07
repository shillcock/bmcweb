class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip_code
      t.date :birthday

      t.timestamps
    end
  end
end
