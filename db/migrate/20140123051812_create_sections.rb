class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :workshop, index: true
      t.string :title

      t.timestamps
    end
  end
end
