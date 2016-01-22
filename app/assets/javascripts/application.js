//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require fastclick
//= require nprogress
//= require nprogress-turbolinks
//= require server_test
//= require server_poller
//= require health_check
//= require highlight
//= require turbolinks

$(function() {
  FastClick.attach(document.body);
  hljs.initHighlightingOnLoad();
});
