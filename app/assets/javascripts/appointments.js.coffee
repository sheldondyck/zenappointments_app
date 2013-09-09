ShowClientAppointmentDialog = ->
    $('#active-hour').removeAttr('id')
    $(this).attr('id', 'active-hour')
    $('#appoinment-template').append('#active-hour')
    $('.hour-field').attr('value', $(this).data('hour'))
    $('.appointment-date').html($(this).data('date-value'))
    $('.appointment-time').html($(this).data('hour-value'))
    $('.appointment-duration').html($(this).data('duration-value'))
    ShowClientAppointmentSearchPartial()
    $('.appointment-dialog').css('display', 'block')
    # TODO 400 is the size of dialog. fix this
    # TODO 12 is a magic number because of arrow
    $('.appointment-dialog').offset({left:$('#active-hour').offset().left + $('#active-hour').width() / 2 - 400 / 2, top:$('#active-hour').offset().top + $('#active-hour').height() - 12})

ShowClientAppointmentSearchPartial = ->
  $('.appointment-client-details').css('display', 'none')
  $('.appointment-client-search').css('display', 'block')
  $('.appointment-client-edit').css('display', 'none')

ShowClientAppointmentEditPartial = ->
  $('.appointment-client-details').css('display', 'none')
  $('.appointment-client-search').css('display', 'none')
  $('.appointment-client-edit').css('display', 'block')

ShowClientAppointmentAddPartial = ->
  $('.appointment-client-details').css('display', 'none')
  $('.appointment-client-search').css('display', 'none')
  $('.appointment-client-edit').css('display', 'block')

HideClientAppointmentDialog = ->
  $('.appointment-dialog').css('display', 'none')
  $('#active-hour').removeAttr('id')

$ ->
  $('.show-client-search').click ->
    ShowClientAppointmentSearchPartial()

$ ->
  $('.show-client-edit').click ->
    ShowClientAppointmentEditPartial()

$ ->
  $('.show-client-add').click ->
    ShowClientAppointmentAddPartial()

$ ->
  $('.close-appointment-dialog').click ->
    HideClientAppointmentDialog()

    # TODO can this be added to the html as a jquery-ujs attribute? such as data-keyup?
$ ->
  $('.search-client').keyup ->
    $.ajax "/clients/search",
      type: 'GET',
      data: {term: $(this).val()}
      error: ->
        alert 'error' # TODO: added generic error handler

#$ ->
#  $('#appointments').show ->
#    alert 'show appointments 2'

#$ ->
#  $('#appointments').live 'change', ->
#    $('.client-appointment').draggable({snap: '.edit-hour'})
#    $('.edit-hour').droppable
#      accept: '.client-appointment',
#      drop: (event, ui) ->
#        # TODO fixed path has to be abstracted.  can`t and shouldn`t use path helpers here.
#        $.ajax "/appointments/move", type: 'POST', data: {appointment_id: $(ui.draggable).data('appointment'), date: $(this).data('date'), hour: $(this).data('hour')}

# TODO: This code had to be duplicated in index.js.haml because view day <-> week changes were losing the event handler. Tried to use live be didn't work.
# Need to find final solution.
$ ->
  $('.client-appointment').draggable({snap: '.edit-hour'})
  $('.edit-hour').droppable
    accept: '.client-appointment',
    drop: (event, ui) ->
      # TODO fixed path has to be abstracted.  can`t and shouldn`t use path helpers here.
      $.ajax "/appointments/move", type: 'POST', data: {appointment_id: $(ui.draggable).data('appointment'), date: $(this).data('date'), hour: $(this).data('hour')}

# TODO:
#$ ->
# $('.client-appointment').live 'draggable', snap: '.edit-hour'
# $('.edit-hour').live 'droppable', ->
#   accept: '.client-appointment',
#   drop: (event, ui) ->
#     # TODO fixed path has to be abstracted.  can`t and shouldn`t use path helpers here.
#     $.ajax "/appointments/move", type: 'POST', data: {appointment_id: $(ui.draggable).data('appointment'), date: $(this).data('date'), hour: $(this).data('hour')}

$ ->
  # TODO: calling ShowClientAppointmentDialog does not work so this code is duplicated
  $('#appointments').delegate '.edit-hour', 'click', ->
    $('#active-hour').removeAttr('id')
    $(this).attr('id', 'active-hour')
    $('#appoinment-template').append('#active-hour')
    $('.hour-field').attr('value', $(this).data('hour'))
    $('.appointment-date').html($(this).data('date-value'))
    $('.appointment-time').html($(this).data('hour-value'))
    $('.appointment-duration').html($(this).data('duration-value'))
    ShowClientAppointmentSearchPartial()
    $('.appointment-dialog').css('display', 'block')
    # TODO 400 is the size of dialog. fix this
    # TODO 12 is a magic number because of arrow
    $('.appointment-dialog').offset({left:$('#active-hour').offset().left + $('#active-hour').width() / 2 - 400 / 2, top:$('#active-hour').offset().top + $('#active-hour').height() - 12})

$ ->
  $('#appointments').delegate '.client-appointment', 'click', (ev) ->
    ev.stopPropagation()
    $('#active-hour').removeAttr('id')
    $('#active-client').removeAttr('id')
    $(this).attr('id', 'active-client')
    $('#appoinment-template').append('#active-client')
    $('.appointment-client-details').css('display', 'block')
    $('.appointment-client-search').css('display', 'none')
    $('.appointment-client-edit').css('display', 'none')
    $('.appointment-dialog').css('display', 'block')
    # TODO 400 is the size of dialog. fix this
    # TODO 12 is a magic number because of arrow
    $('.appointment-dialog').offset({left:$('#active-client').offset().left + $('#active-client').width() / 2 - 400 / 2, top:$('#active-client').offset().top + $('#active-client').height() - 12})
