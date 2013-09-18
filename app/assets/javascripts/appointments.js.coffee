(exports ? this).ShowClientAppointmentDialog = ->
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

(exports ? this).SetupClientAppointmentDragDrop = ->
  #alert 'SetupClientAppointmentDragDrop'
  $('.client-appointment').draggable(
    {
      snap: '.edit-hour',
      containment: '.appointment',
      drag: ->
        offset = $(this).offset()
        xPos = offset.left
        yPos = offset.top
        #$(this).text('x: ' + xPos + ' y: ' + yPos)
      stop: ->
        #alert 'stopped'
    }
  )
  $('.edit-hour').droppable
    accept: '.client-appointment',
    drop: (event, ui) ->
      #alert 'drop'
      # TODO fixed path has to be abstracted.  can`t and shouldn`t use path helpers here.
      # TODO this is duplicated in index.js.haml. and it causing headaches!
      $(ui.draggable).appendTo $(this) if $(ui.draggable).parent() isnt $(this)
      $.ajax "/appointments/move", type: 'POST', data: {appointment_id: $(ui.draggable).data('appointment'), date: $(this).data('date'), hour: $(this).data('hour')}
    over: ->
      #$(this).animate({'border-width': '2px', 'border-color': '#4a4'}, 500)
      #$(this).animate({'box-shadow': 'inset 0 0 3px 3px rgba(68,170,68,0.7)'}, 500)

(exports ? this).ShowClientAppointmentSearchPartial = ->
  $('.appointment-client-details').css('display', 'none')
  $('.appointment-client-search').css('display', 'block')
  $('.appointment-client-edit').css('display', 'none')

(exports ? this).ShowClientAppointmentEditPartial = ->
  $('.appointment-client-details').css('display', 'none')
  $('.appointment-client-search').css('display', 'none')
  $('.appointment-client-edit').css('display', 'block')

(exports ? this).ShowClientAppointmentAddPartial = ->
  $('.appointment-client-details').css('display', 'none')
  $('.appointment-client-search').css('display', 'none')
  $('.appointment-client-edit').css('display', 'block')

(exports ? this).HideClientAppointmentDialog = ->
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

$ -> SetupClientAppointmentDragDrop()

$ -> ShowClientAppointmentDialog()

$ ->
  # TODO is this needed?
  # TODO lots of duplicate code here
  # TODO CLEAN UP!
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
