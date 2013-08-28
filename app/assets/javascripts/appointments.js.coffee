jQuery.fn.registerNewAgendaDialog = (raw_dialog) ->
  @find('.edit-hour').click ->
    hour = $(this).data('hour')
    # TODO this is terrible!!!!! YUCK!!!!
    # is the problem me or jquery? probably me
    raw_dialog_hour = raw_dialog.replace('HOUR', hour)
    $('#active-hour').removeAttr('id')
    $(this).attr('id', 'active-hour')
    $('.appointment-dialog').remove()
    $('#appointments-panel').append(raw_dialog_hour)
    #$('.appointment-dialog').offset({left:$(this).offset().left, top: $(this).offset().top - $(this).height()*2})
    #alert($(this).left + $(this).width / 2)
    #alert($(this).left + $('#active-hour').width() / 2)
    #alert($(this).left)
    #alert($('#active-hour').width() / 2)
    #alert($('#active-hour').offset().left)
    # TODO 400 is the size of dialog. fix this
    $('.appointment-dialog').offset({left:$('#active-hour').offset().left + $('#active-hour').width() / 2 - 400 / 2, top:$('#active-hour').offset().top - 2})
    #$('.new-appointment').modal()
    #$('#new-appointment').modal('show')
  this

jQuery.fn.registerNewCalendarDialog = (dialog) ->
  @find('.edit-day').click ->
    $(this).append(dialog)
  this

jQuery ->
  $('.client-appointment').draggable()
