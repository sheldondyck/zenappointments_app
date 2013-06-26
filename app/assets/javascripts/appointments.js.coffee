# TODO: add style to .css
jQuery.fn.registerNewAgendaDialog = (dialog) ->
  @find('.edit_hour').click ->
    $(this).css('background-color', '#0d0')
    $(this).append(dialog)
  this
