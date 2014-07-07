class CreateAlumniMemberships < ActiveRecord::Migration
  def change
    create_table :alumni_memberships do |t|
      t.references :user, index: true
      t.string :stripe_subscription_id
      t.string :stripe_token
      t.integer :amount
      t.string :interval, default: "month"
      t.date :deactivated_on

      t.timestamps
    end
  end
end
