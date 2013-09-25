(exports ? this).InstallShowClientAppointmentDialogHandler = ->
  # TODO lots of duplicate code here
  $('#appointments').delegate '.edit-hour', 'click', ->
    $('#active-hour').removeAttr('id')
    $(this).attr('id', 'active-hour')
    $('#appoinment-template').append('#active-hour')
    $('.hour-field').attr('value', $(this).closest('tr.hour-row').data('hour'))
    $('.appointment-weekday').html($(this).data('weekday'))
    $('.appointment-date').html($(this).data('date-pretty'))
    # TODO need to remove hour interval and replace with something more flexible. (multiples of 5mins or 15mins?)
    $('.appointment-time').html($(this).closest('tr.hour-row').data('interval'))
    $('.appointment-duration').html($(this).closest('tr.hour-row').data('duration') + " mins.")
    ShowClientAppointmentSearchPartial()
    $('.appointment-dialog').css('display', 'block')
    # TODO 400 is the size of dialog. fix this
    # TODO 12 is a magic number because of arrow
    $('.appointment-dialog').offset({left:$('#active-hour').offset().left + $('#active-hour').width() / 2 - 400 / 2, top:$('#active-hour').offset().top + $('#active-hour').height() - 12})

(exports ? this).InstallClientAppointmentHandler = ->
  #alert 'InstallClientAppointmentHandler'
  $('#appointments').delegate '.client-appointment', 'click', (ev) ->
    ev.stopPropagation()
    $('#active-hour').removeAttr('id')
    $('#active-client').removeAttr('id')
    $(this).attr('id', 'active-client')
    $('#appoinment-template').append('#active-client')
    ShowClientAppointmentDetailsPartial()
    $('.appointment-weekday').html($(this).closest('.edit-hour').data('weekday'))
    $('.appointment-date').html($(this).closest('.edit-hour').data('date-pretty'))
    # TODO need to remove hour interval and replace with something more flexible. (multiples of 5mins or 15mins?)
    $('.appointment-time').html($(this).data('interval'))
    $('.appointment-duration').html($(this).data('duration') + " mins.")

    $('.appointment-field .name').html($(this).data('name'))
    $('.appointment-field .email').html($(this).data('email'))
    $('.appointment-field .telephone-cellular').html($(this).data('telephone-cellular'))

    $('.appointment-dialog').css('display', 'block')
    # TODO 400 is the size of dialog. fix this
    # TODO 12 is a magic number because of arrow
    $('.appointment-dialog').offset({left:$('#active-client').offset().left + $('#active-client').width() / 2 - 400 / 2, top:$('#active-client').offset().top + $('#active-client').height() - 12})
  $('.client-appointment').draggable
    snap: '.edit-hour',
    containment: '.appointment',
    drag: ->
      offset = $(this).offset()
      xPos = offset.left
      yPos = offset.top
      #$(this).text('x: ' + xPos + ' y: ' + yPos)
    stop: (event, ui) ->
      #alert 'stopped ' + $(ui.draggable).data('appointment') +
      #      ' date: ' + $(this).data('date') +
      #      ' hour: ' + $(this).closest('tr.hour-row').data('hour')
  $('.edit-hour').droppable
    accept: '.client-appointment',
    tolerance: 'pointer',
    drop: (event, ui) ->
      #alert 'drop pos top:' + ui.position.top + ' left:' + ui.position.left
      $(ui.draggable).appendTo $(this) if $(ui.draggable).parent() isnt $(this)
      # TODO fixed path has to be abstracted.  can`t and shouldn`t use path helpers here.
      $.ajax "/appointments/move",
        type: 'POST',
        data: {
          appointment_id: $(ui.draggable).data('appointment'),
          date: $(this).data('date'),
          hour: $(this).closest('tr.hour-row').data('hour')
        },
    over: ->
      #$(this).animate({'border-width': '2px', 'border-color': '#4a4'}, 500)
      #$(this).animate({'box-shadow': 'inset 0 0 3px 3px rgba(68,170,68,0.7)'}, 500)
  #$('.agenda').droppable
  #  accept: '.client-appointment',
  #  drop: (event, ui) ->
  #    #alert 'drop agenda'
  $('.hour-grid').resizable
    grid: [100, 50]
  $('.client-appointment').resizable
    # TODO magic number comes from appointments.css.scss $hour-height:50px;
    handles: 's',
    stop: (event, ui) ->
      $.ajax "/appointments/update",
        type: 'POST',
        data: {
          appointment_id: $(ui.element).data('appointment'),
          duration: parseInt((ui.size.height + 59) / 60) * 60
        }

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

(exports ? this).ShowClientAppointmentDetailsPartial = ->
  $('.appointment-client-details').css('display', 'block')
  $('.appointment-client-search').css('display', 'none')
  $('.appointment-client-edit').css('display', 'none')

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
      data: { term: $(this).val() }
      error: ->
        #alert 'error' # TODO: added generic error handler


$ -> InstallClientAppointmentHandler()
$ -> InstallShowClientAppointmentDialogHandler()

