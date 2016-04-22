//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require fastclick
//= require server_test
//= require server_poller
//= require health_check
//= require highlight
//= require turbolinks

$(function() {
  FastClick.attach(document.body);
  hljs.initHighlightingOnLoad();
});
