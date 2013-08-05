jQuery.fn.registerNewAgendaDialog = (raw_dialog) ->
  @find('.edit_hour').click ->
    $('#active_hour').removeAttr('id')
    $(this).attr('id', 'active_hour')
    $('.new_appointment').remove()
    $('#appointments_panel').append(raw_dialog)
    $('.new_appointment').offset({left: $(this).offset().left + $(this).width(), top: $(this).offset().top - $(this).height()/2})
  this

jQuery.fn.registerNewCalendarDialog = (dialog) ->
  @find('.edit_day').click ->
    $(this).append(dialog)
  this
