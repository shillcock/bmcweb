class CreateIntroMeetingRegistrations < ActiveRecord::Migration
  def change
    create_table :intro_meeting_registrations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :intro_meeting, index: true

      t.timestamps
    end
  end
end
