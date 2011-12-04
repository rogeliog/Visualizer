# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
`
$(function() {
  // Hide the elements

  $("#config").hide();
  $("#new").hide();
  $("#share").hide();
  $("#action-1").hide();
  $("#action-2").hide();
  $("#action-3").hide();

  // Menu triggers
  $('.trigger').click(function() {
    $("#new").hide();
    $("#config").hide();
    $("#share").hide();
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


  $( "#menu" ).draggable();


});


`
