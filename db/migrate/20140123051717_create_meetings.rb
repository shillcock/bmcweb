class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :date
      t.time :starts_at
      t.time :ends_at
      t.references :lesson, index: true
      t.references :section, index: true

      t.timestamps
    end
  end
end
