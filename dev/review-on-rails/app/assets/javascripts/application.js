// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {

    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
    });

    var dateTimeElement, utc;

    $(".date-time").each(function(i) {
        dateTimeElement = $(this);
        utc = dateTimeElement.text();
        dateTimeElement.text(convertUTC(utc));
    });

    function convertUTC(utc) {
        var utcStr = utc.trim();
               utc = Math.round(new Date(utcStr).getTime()/1000);
          var date = moment.unix(utc).format("YYYYMMMDD");
              date = moment(date, "YYYYMMMDD").fromNow();
        return date;
    };

});
