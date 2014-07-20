jQuery ->
  $('#users').dataTable
    ajax: $('#users').data('source')
    columns: [
      { data: "id" }
      { data: "name" }
      { data: "email" }
      { data: "birthday" }
    ]
