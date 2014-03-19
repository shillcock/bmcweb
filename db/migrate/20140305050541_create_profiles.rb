class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
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
