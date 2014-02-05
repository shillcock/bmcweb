jQuery ->
  new SectionCalendar("#sectionCalendar")

class SectionCalendar
  constructor: (el) ->
    $cal = $(el)
    $cal.fullCalendar
      defaultDate: $cal.data("start-date")
      editable: true
      events:
        url: $cal.data("meetings-url")
        error: @handleError
      eventDrop: @updateEvent
      eventResize: @updateEvent

  handleError: ->
    alert "there was an error while fetching events!"

  updateEvent: (event, revertFunc) ->
    $.ajax
      url: event.update_url
      type: "PUT"
      data:
        meeting:
          starts_at: event.start.format()
          ends_at: event.end.format()
      success: (data) ->
        el = "#meeting_" + event.id
        $(el).text event.start.format("MMMM DD, YYYY")
        $(el).effect "highlight", {}, 3000
        return false
      error: (data) ->
        alert "post error: " + JSON.stringify(data)
        revertFunc()
        return false
