class DropLessonsAndSections < ActiveRecord::Migration
  def change
    drop_table :lessons
    drop_table :sections
  end
end
