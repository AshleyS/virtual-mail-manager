// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  $("#mailboxes_search input").attr('autocomplete', 'off');
  $("#mailaliases_search input").attr('autocomplete', 'off');
  $("#domains_search input").attr('autocomplete', 'off');

  $("#mailboxes_search input[type='submit']").click(function(e) {
    e.preventDefault();
    $.get($("#mailboxes_search").attr("action"), $("#mailboxes_search").serialize(), null, "script");
  });

  $("#mailaliases_search input[type='submit']").click(function(e) {
    e.preventDefault();
    $.get($("#mailaliases_search").attr("action"), $("#mailaliases_search").serialize(), null, "script");
  });

  $("#domains_search input[type='submit']").click(function(e) {
    e.preventDefault();
    $.get($("#domains_search").attr("action"), $("#domains_search").serialize(), null, "script");
  });



  $("#mailboxes table th a, #mailboxes .pagination a").live("click", function(e) {
    e.preventDefault();
    $.getScript(this.href);
  });

  $("#mailaliases table th a, #mailaliases table .pagination a").live("click", function(e) {
    e.preventDefault();
    $.getScript(this.href);
  });

  $("#domains table th a, #domains table .pagination a").live("click", function(e) {
    e.preventDefault();
    $.getScript(this.href);
  });
});
