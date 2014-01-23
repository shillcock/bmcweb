class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :summary
      t.integer :lesson_number
      t.references :workshop, index: true

      t.timestamps
    end
  end
end
