jQuery ->
  $("#intro_meeting_starts_at").ptTimeSelect()
  $("#intro_meeting_ends_at").ptTimeSelect()
  $('#intro_meeting_date').datepicker
    format: 'yyyy-mm-dd'
    autoclose: true
