# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  append_dataset_column = (column_name)->
    elem = $("<li><input type=\"checkbox\" name=\"column_name\" value=\"#{column_name}\" /> #{column_name}</li>")
    $('#config ul').append(elem)

  $('#datasets a').click (e)->
    e.preventDefault()
    id = $(this).attr('data')
    $.getJSON "/datasets/#{id}", (data, status)->
      console.log(data)
      $('#config ul').html('')
      append_dataset_column column for column in data.column_names
