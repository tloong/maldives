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
//= require jquery_nested_form

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
  $('#reservationtime').daterangepicker({ timePicker: true, timePickerIncrement: 30, format: 'YYYY/MM/DD' });
});

$(document).ready(function() {
$('#reportrange').daterangepicker(
    {
      format: 'YYYY/MM/DD',
      ranges: {
         'Today': [moment(), moment()],
         'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
         'Last 7 Days': [moment().subtract('days', 6), moment()],
         'Last 30 Days': [moment().subtract('days', 29), moment()],
         'This Month': [moment().startOf('month'), moment().endOf('month')],
         'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
      },
      startDate: moment().subtract('days', 29),
      endDate: moment()
    },
    function(start, end) {
        $('#reportrange').html(start.format('M/D, YYYY') + ' - ' + end.format('M/D, YYYY'));
    }
);

$('#reportrange').on('show.daterangepicker', function(ev, picker) {
  //do something, like clearing an input
  var $radios = $('input:radio[name=specific_duration]');
        $radios.filter('[value=specific]').prop('checked', true);
});

});


  $(document).ready(function() { $("[data-behaviour~=vendor_select2]").select2(); });
  