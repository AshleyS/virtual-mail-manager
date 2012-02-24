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

});
