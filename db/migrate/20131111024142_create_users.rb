class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
  end
  
  def self.down
    drop_table :users
  end
end
