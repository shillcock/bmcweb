jQuery ->
  $("#meeting_form_date").daterangepicker
    showDropdowns: true
    timePicker: true
    format: 'YYYY-MM-DD h:mm A'

  # $("#meeting_starts_at_date").datetimepicker
  #   pickTime: false

  # $("#meeting_starts_at_time").datetimepicker
  #   pickDate: false

  # $("#meeting_ends_at_date").datetimepicker
  #   pickTime: false

  # $("#meeting_ends_at_time").datetimepicker
  #   pickDate: false

  # $("#meeting_starts_at_date").on "dp.change", (e) ->
  #  $("#meeting_ends_at_date").data("DateTimePicker").setMinDate(e.date)

  # $("#meeting_ends_at_date").on "dp.change", (e) ->
  #  $("#meeting_starts_at_date").data("DateTimePicker").setMaxDate(e.date)
