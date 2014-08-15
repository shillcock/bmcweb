class SplitMeetingDateTimeColumn < ActiveRecord::Migration
  def change
    rename_column :meetings, :starts_at, :start_time
    rename_column :meetings, :ends_at, :end_time

    change_column :meetings, :start_time, :time
    change_column :meetings, :end_time, :time

    add_column :meetings, :start_date, :date
    add_column :meetings, :end_date, :date
  end
end
