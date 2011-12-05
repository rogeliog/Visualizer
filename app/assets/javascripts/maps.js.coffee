# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
`
$(function() {
  // Hide the elements


  $("#loader").hide();
  $("#top").hide();
    $("#new").hide();
    $("#config").hide();
    $("#share").hide();

  // Menu triggers
  $('#top span').click(function() {
    $("#new").slideUp();
    $("#config").slideUp();
    $("#share").slideUp();
    $('#top').slideUp();
    $('#menu').hide();
  });

  $('.trigger').click(function() {
    $('#menu').show();
    $("#new").hide();
    $("#config").hide();
    $("#share").hide();
      $("#top").fadeIn();
    $("#"+$(this).attr("rel")).fadeIn();
    if($(this).attr("rel")=='new')
      $("#action-1").fadeIn();

  });

    // Menu triggers
  $('#info_top span').click(function() {
    $('#info_menu').hide();
  });


  // Upload wizard
  $('.next-action').click(function() {
    var act = $(this).parent().attr("act");
    $("#action-"+act).hide();
    $("#action-"+(parseInt(act)+1)).fadeIn();

  });

  $('#new form').submit(function() {
    $("#loader").fadeIn();
  });



  // Temporary light box for Sign In and Sign Up links
  $('#overlay').css('opacity', '0.4');

  $('.user-login-menu a').click(function (e) {
    e.preventDefault();
    $('#overlay, #lightbox').show();
  });

  $('#lightbox #close').click(function (e) {
    e.preventDefault();
    $('#overlay, #lightbox').hide();
  });
  
  $('.main-menu a#who').click(function (e) {
    e.preventDefault();
    $('#overlay, #who_info').show();
  });

  $('#who_info #close_who').click(function (e) {
    e.preventDefault();
    $('#overlay, #who_info').hide();
  });

});


`
