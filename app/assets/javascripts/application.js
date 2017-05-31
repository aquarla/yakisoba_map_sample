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
//= require underscore
//= require gmaps/google
//= require jquery
//= require jquery_ujs
//= require js.cookie
//= require foundation
//= require turbolinks
//= require_tree ./main

$(function(){ $(document).foundation(); });

$(function(){
  function search1() {
    var value = $('.search1').val();
    window.location.href = '/?q=' + encodeURIComponent(value);     
  }
  function search2() {
    var value = $('.search2').val();
    window.location.href = '/?q=' + encodeURIComponent(value);     
  }

  $('.button1').click(search1);
  $('.button2').click(search2);

  $('.search1').keypress(function(e){
    if (e.which == 13) { search1(); }
  });
  $('.search2').keypress(function(e){
    if (e.which == 13) { search2(); }
  });
});
