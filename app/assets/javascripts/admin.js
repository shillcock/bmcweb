//= require jquery
//= require jquery_ujs
//= require foundation
//= require segmentio

$(function() {
  $(document).foundation();

  // accommodate Turbolinks and track page views
  $(document).on('ready page:change', function() {
    analytics.page();
  })
});
