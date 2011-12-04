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

  // Upload wizard
  $('.next-action').click(function() {
    var act = $(this).parent().attr("act");
    $("#action-"+act).hide();
    $("#action-"+(parseInt(act)+1)).fadeIn();

  });

  $('#new form').submit(function() {
    $("#loader").fadeIn();
  });




});


`
