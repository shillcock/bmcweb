class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :workshop, index: true

      t.timestamps
    end
  end
end
