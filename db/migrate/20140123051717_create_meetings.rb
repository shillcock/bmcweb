class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :lesson, index: true
      t.references :section, index: true

      t.timestamps
    end
  end
end
