jQuery ->
  # $('#intro_meeting_date').datetimepicker
  #   pickTime: false
  $('#intro_meeting_date').daterangepicker
    format: 'YYYY-MM-DD'
    singleDatePicker: true
    startDate: moment()
    showDropdowns: true

  #$("#intro_meeting_starts_at").datetimepicker
  #  pickDate: false

  #$("#intro_meeting_ends_at").datetimepicker
  #  pickDate: false

