class CreateIntroMeetings < ActiveRecord::Migration
  def change
    create_table :intro_meetings do |t|
      t.string :title
      t.text :description
      t.date :date
      t.time :starts_at, :default => Time.parse('19:00')
      t.time :ends_at, :default => Time.parse('21:00')

      t.timestamps
    end
  end
end
