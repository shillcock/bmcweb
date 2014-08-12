class AddLessonFieldsToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :title, :string
    add_column :meetings, :meeting_number, :integer
    add_column :meetings, :workshop_id, :integer
    add_index :meetings, :workshop_id

    remove_column :meetings, :section_id
    remove_column :meetings, :lesson_id
  end
end
