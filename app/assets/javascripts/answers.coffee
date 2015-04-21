# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

newAnswerSuccess = (e, data, status, xhr) ->
  answer = $.parseJSON(xhr.responseText);
  $('.answers').append(answer.text);

newAnswerError = (e, xhr, status, error) ->
  errors = $.parseJSON(xhr.responseText)
  $('.answer-errors').html('')
  $.each errors, (index, value) ->
    $('.answer-errors').append(value)


$(document).on 'ajax:error', 'form#new_answer', newAnswerError
$(document).on 'ajax:success', 'form#new_answer', newAnswerSuccess 