class CreateIntroMeetings < ActiveRecord::Migration
  def change
    create_table :intro_meetings do |t|
      t.string :title
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
