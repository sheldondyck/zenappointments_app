jQuery.fn.registerNewAgendaDialog = (raw_dialog) ->
  @find('.edit-hour').click ->
    # TODO very fragil code.  only works if class is "some_class hour-X". better way? angular?
    hour = $(this).attr('class').split(' ')[1].replace('hour-', '')
    # TODO this is terrible!!!!! YUCK!!!!
    # is the problem me or jquery? probably me
    raw_dialog_hour = raw_dialog.replace('HOUR', hour)
    $('#active-hour').removeAttr('id')
    $(this).attr('id', 'active-hour')
    $('.new-appointment').remove()
    $('#appointments-panel').append(raw_dialog_hour)
    #$('.new-appointment').offset({left:$(this).offset().left, top: $(this).offset().top - $(this).height()*2})
    $('.new-appointment').offset({left:$(this).offset().left, top:$(this).offset().top + $(this).height()*2})
  this

jQuery.fn.registerNewCalendarDialog = (dialog) ->
  @find('.edit-day').click ->
    $(this).append(dialog)
  this

jQuery ->
  $('.client-appointment').draggable({containment: "#display_container"})
