// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/dropdown
//= require bootstrap/alert
//= require bootstrap/tab
//= require cocoon
//= require bootstrap-datepicker
//= require select2
//= require select2_locale_zh-TW
//= require moment
//= require daterangepicker

// Do not keep bank spaces between included files.
  $(document).ready(function(){    
    $("[data-behaviour~=datepicker]").datepicker({
                           format: "yyyy-mm-dd",
                           autoclose: true,
                           }).on('changeDate', function(ev){
        // do what you want here
        $("[data-behaviour~=datepicker]").datepicker('hide');})
    $("[data-behaviour~=datepicker-month]").datepicker({
                           format: "yyyy-mm",                    
                           viewMode: "months", 
                           minViewMode: "months",
                           autoclose: true,
                           }).on('changeDate', function(ev){
        // do what you want here
        $("[data-behaviour~=datepicker-month]").datepicker('hide');})

  })
$(document).ready(function() {
  $('#reservationtime').daterangepicker({ timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A' });
});
  $(document).ready(function() { $("[data-behaviour~=vendor_select2]").select2(); });
  