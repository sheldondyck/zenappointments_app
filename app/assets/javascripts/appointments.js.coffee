$ ->
  $('.edit-hour').click ->
    _hour = $(this).data('hour')
    $('#active-hour').removeAttr('id')
    $(this).attr('id', 'active-hour')
    $(this).attr('data-hour', _hour)
    $('#appoinment-template').append('#active-hour')
    $('.appointment-dialog').css('display', 'block')
    # TODO 400 is the size of dialog. fix this
    $('.appointment-dialog').offset({left:$('#active-hour').offset().left + $('#active-hour').width() / 2 - 400 / 2, top:$('#active-hour').offset().top - 2})

$ ->
  $('.client-appointment').draggable({snap: '.edit-hour'})
  $('.edit-hour').droppable
    accept: '.client-appointment',
    drop: (event, ui) ->
      # TODO fixed path has to be abstracted.  can`t and shouldn`t use path helpers here.
      $.ajax "/appointments/move", type: 'POST', data: {appointment_id: $(ui.draggable).data('appointment'), date: $(this).data('date'), hour: $(this).data('hour')}

$ ->
  $('.appointment-close').click ->
    $('.appointment-dialog').css('display', 'none')
    $('#active-hour').removeAttr('id')

$ ->
  $('.client-search').click ->
    $('.appointment-client-details').css('display', 'none')
    $('.appointment-client-search').css('display', 'block')
    $('.appointment-client-edit').css('display', 'none')

$ ->
  $('.client-edit').click ->
    $('.appointment-client-details').css('display', 'none')
    $('.appointment-client-search').css('display', 'none')
    $('.appointment-client-edit').css('display', 'block')

$ ->
  $('.client-add').click ->
    $('.appointment-client-details').css('display', 'none')
    $('.appointment-client-search').css('display', 'none')
    $('.appointment-client-edit').css('display', 'block')
