jQuery ->
  $("#meeting_starts_at").datetimepicker()
  $("#meeting_ends_at").datetimepicker()

  $("#meeting_starts_at").on "dp.change", (e) ->
    $("#meeting_ends_at").data("DateTimePicker").setMinDate e.date

  $("#meeting_ends_at").on "dp.change", (e) ->
    $("#meeting_starts_at").data("DateTimePicker").setMaxDate e.date
