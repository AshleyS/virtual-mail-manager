// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.min
//= require jquery_ujs
//= require_tree .

function do_search( inputId ) {

  $('<img />').attr({
    'src': '/../images/ajax-loader.gif',
    'class': 'ajax_load'
  }).insertBefore($('#search'));

  $.get(
    $(inputId).attr("action"),
    $(inputId).serialize(),
    null,
    "script"
  );

}

$(function() {
  $("#mailboxes_search input[type='text']").attr('autocomplete', 'off');
  $("#mailaliases_search input[type='text']").attr('autocomplete', 'off');
  $("#domains_search input[type='text']").attr('autocomplete', 'off');
  $("#users_search input[type='text']").attr('autocomplete', 'off');

  $("#mailboxes_search input[type='submit']").click(function(e) {
    e.preventDefault();
    do_search("#mailboxes_search")
  });

  $("#mailaliases_search input[type='submit']").click(function(e) {
    e.preventDefault();
    do_search("#mailaliases_search")
  });

  $("#domains_search input[type='submit']").click(function(e) {
    e.preventDefault();
    do_search("#domains_search")
  });

  $("#users_search input[type='submit']").click(function(e) {
    e.preventDefault();
    do_search("#users_search")
  });


  $("#mailboxes table th a, #mailboxes .pagination a").live("click", function(e) {
    e.preventDefault();
    $.getScript(this.href);
  });

  $("#mailaliases table th a, #mailaliases .pagination a").live("click", function(e) {
    e.preventDefault();
    $.getScript(this.href);
  });

  $("#domains table th a, #domains .pagination a").live("click", function(e) {
    e.preventDefault();
    $.getScript(this.href);
  });

  $("#users table th a, #users .pagination a").live("click", function(e) {
    e.preventDefault();
    $.getScript(this.href);
  });

  if ( $('.notification_box').length > 0 ) {
    $('.notification_box').fadeIn();
    $('.notification_box_close').click( function() {
      closeNotificationBox();
    });
		setTimeout( closeNotificationBox, 5000 );
  }

  function closeNotificationBox() {
    $('.notification_box').fadeOut();
  }

  $('#user_admin').click(function() {
    if ( this.checked ) {
      //alert('yes');
      $('input[id^="domain_"]').attr('checked', 'checked');
      $('input[id^="domain_"]').attr('disabled', 'disabled');
    }
    else {
      //alert('false');
      $('input[id^="domain_"]').removeAttr('checked');
      $('input[id^="domain_"]').removeAttr('disabled');
    }
  });

});
