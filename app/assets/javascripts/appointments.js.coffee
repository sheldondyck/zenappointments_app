# TODO: add style to .css
jQuery.fn.registerNewAgendaDialog = (_dialog) ->
  @find('.edit_hour').click ->
    $(this).css('background-color', '#0a0')
    $(this).append(_dialog)
  this

jQuery.fn.registerNewCalendarDialog = (_dialog) ->
  @find('.edit_day').click ->
    $(this).css('background-color', '#0a0')
    $(this).append(_dialog)
  this
