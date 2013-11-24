class CreateIntroMeetings < ActiveRecord::Migration
  def change
    create_table :intro_meetings do |t|
      t.date :date
      t.time :starts_at
      t.time :ends_at

      t.timestamps
    end
  end
end
