//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require fastclick
//= require server_test
//= require server_poller
//= require health_check
//= require highlight
//= require close_notification
//= require clipboard
//= require form_errors
//= require modal
//= require turbolinks

$(document).on("turbolinks:load", function() {
  FastClick.attach(document.body);
  hljs.initHighlightingOnLoad();
  new Clipboard('.copy');
});
