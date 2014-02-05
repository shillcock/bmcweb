@meetings.map do |meeting|
  {
    id: meeting.id,
    title: meeting.short_name,
    start: meeting.starts_at.to_date,
    end: meeting.ends_at.to_date,
    update_url: admin_section_meeting_path(meeting.section, meeting, format: :json)
  }
end.to_json
