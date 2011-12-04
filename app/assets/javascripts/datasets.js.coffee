# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  append_dataset_column = (column_name)->
    radio = $("<input type=\"radio\" name=\"column_name\" id=\"#{column_name}\" value=\"#{column_name}\" />")
    label = $("<label for=\"#{column_name}\"> #{column_name}</label>")
    item = $("<li></li>").append(radio).append(label)
    $('#config ul').append(item)

  $('#datasets a').click (e)->
    e.preventDefault()
    id = $(this).attr('data')
    $.getJSON "/datasets/#{id}", (data, status)->
      console.log(data)
      $('#config ul').html('')
      append_dataset_column column for column in data.column_names
