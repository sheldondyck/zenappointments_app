jQuery.fn.registerNewAgendaDialog = (raw_dialog) ->
  @find('.edit_hour').click ->
    # TODO very fragil code.  only works if class is "some_class hour". better way? angular?
    hour = $(this).attr('class').split(' ')[1]
    # TODO this is terrible!!!!! YUCK!!!!
    # is the problem me or jquery?
    raw_dialog_hour = raw_dialog.replace('HOUR', hour)
    $('#active_hour').removeAttr('id')
    $(this).attr('id', 'active_hour')
    $('.new_appointment').remove()
    $('#appointments_panel').append(raw_dialog_hour)
    $('.new_appointment').offset({left:$(this).offset().left, top: $(this).offset().top - $(this).height()})
  this

jQuery.fn.registerNewCalendarDialog = (dialog) ->
  @find('.edit_day').click ->
    $(this).append(dialog)
  this
