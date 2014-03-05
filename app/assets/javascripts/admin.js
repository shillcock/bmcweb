//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require segmentio
//= require bootstrap
//= require moment.min
//= require bootstrap-datepicker
//= require jquery.ptTimeSelect
//= require fullcalendar
//= require admin/intro_meetings
//= require admin/workshops
//= require admin/sections

$(function() {

  // sidebar menu dropdown toggle
  $("#dashboard-menu .dropdown-toggle").click(function (e) {
    e.preventDefault();
    var $item = $(this).parent();
    $item.toggleClass("active");
    if ($item.hasClass("active")) {
      $item.find(".submenu").slideDown("fast");
    } else {
      $item.find(".submenu").slideUp("fast");
    }
  });

});
