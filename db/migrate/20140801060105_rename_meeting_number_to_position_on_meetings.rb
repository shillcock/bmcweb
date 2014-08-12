class RenameMeetingNumberToPositionOnMeetings < ActiveRecord::Migration
  def change
    rename_column :meetings, :meeting_number, :position
  end
end
