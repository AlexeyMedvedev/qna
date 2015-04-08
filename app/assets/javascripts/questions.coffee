# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

editAnswerFunction = (e) ->
  e.preventDefault();
  $(this).hide();
  answer_id = $(this).data('answerId');
  $('form#edit-answer-' + answer_id).show();

editQuestionFunction = (e) ->
  e.preventDefault();
  $(this).hide();
  # question_id = $(this).data('questionId');
  $('form#edit-question').show();

$(document).on 'click', '.answers .edit-answer-link', editAnswerFunction
$(document).on 'click', '.question .edit-question-link', editQuestionFunction