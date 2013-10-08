(exports ? this).InstallShowClientAppointmentDialogHandler = ->
  # TODO lots of duplicate code here
  $('#appointments').delegate '.edit-hour', 'click', ->
    $('#active-hour').removeAttr('id')
    $(this).attr('id', 'active-hour')
    #$(this).append($('.appointment-dialog'))
    ShowClientAppointmentSearchPartial()
    $('.hour-field').attr('value', $(this).closest('tr.hour-row').data('hour'))
    $('.appointment-weekday').html($(this).data('weekday'))
    $('.appointment-date').html($(this).data('date-pretty'))
    # TODO need to remove hour interval and replace with something more flexible. (multiples of 5mins or 15mins?)
    $('.appointment-time').html($(this).closest('tr.hour-row').data('interval'))
    $('.appointment-duration').html($(this).closest('tr.hour-row').data('duration') + " mins.")
    $('.appointment-dialog').css('display', 'block')
    $('.appointment-dialog').css('visibility', 'visible')
    $('input.client_id').val('')

    $('.if-client-not-exists').css('display', 'block')
    $('.if-client-exists').css('display', 'none')

    ResetClientAppointmentDialog()

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
    #$(this).append($('.appointment-dialog'))
    ShowClientAppointmentDetailsPartial()
    $('.appointment-weekday').html($(this).closest('.edit-hour').data('weekday'))
    $('.appointment-date').html($(this).closest('.edit-hour').data('date-pretty'))
    # TODO need to remove hour interval and replace with something more flexible. (multiples of 5mins or 15mins?)
    $('.appointment-time').html($(this).data('interval'))
    $('.appointment-duration').html($(this).data('duration') + " mins.")
    $('.appointment-field .name').html($(this).data('name'))
    $('.appointment-field .email').html($(this).data('email'))
    $('.appointment-field .telephone-cellular').html($(this).data('telephone-cellular'))
    $('.appointment-dialog').attr('data-appointment', $(this).data('appointment'))
    $('input.client_id').val($(this).data('client'))

    $('.if-client-not-exists').css('display', 'none')
    $('.if-client-exists').css('display', 'block')
    $('.appointment-dialog-error').css('display', 'none')

    # Load client into form
    $('.first-name').val($(this).data('first-name'))
    $('.last-name').val($(this).data('last-name'))
    $('.email').val($(this).data('email'))
    $('.telephone-cellular').val($(this).data('telephone-cellular'))

    $('.appointment-dialog').css('display', 'block')
    $('.appointment-dialog').css('visibility', 'visible')
    # TODO 400 is the size of dialog. fix this
    # TODO 12 is a magic number because of arrow
    $('.appointment-dialog').offset({left:$('#active-client').offset().left + $('#active-client').width() / 2 - 400 / 2, top:$('#active-client').offset().top + $('#active-client').height() - 12})
  $('.client-appointment').draggable
    snap: '.slot',
    containment: '.appointment',
    start: ->
      HideClientAppointmentDialog()
    drag: ->
      offset = $(this).offset()
      xPos = offset.left
      yPos = offset.top
      #$(this).text('x: ' + xPos + ' y: ' + yPos)
    stop: (event, ui) ->
      #alert 'stopped ' + $(ui.draggable).data('appointment') +
      #      ' date: ' + $(this).data('date') +
      #      ' hour: ' + $(this).closest('tr.hour-row').data('hour')
  $('.slot').droppable
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
          date: $(this).closest('.edit-hour').data('date'),
          hour: $(this).closest('tr.hour-row').data('hour'),
          slot: $(this).data('slot')
        },
    over: ->
      #$(this).animate({'border-width': '2px', 'border-color': '#4a4'}, 500)
      #$(this).animate({'box-shadow': 'inset 0 0 3px 3px rgba(68,170,68,0.7)'}, 500)
  #$('.agenda').droppable
  #  accept: '.client-appointment',
  #  drop: (event, ui) ->
  #    #alert 'drop agenda'
  $('.hour-grid').resizable
    grid: [100, 10]
  $('.client-appointment').resizable
    # TODO magic number comes from appointments.css.scss $hour-height:50px;
    handles: 's',
    stop: (event, ui) ->
      $.ajax "/appointments/update",
        type: 'POST',
        data: {
          appointment_id: $(ui.element).data('appointment'),
          # TODO duration cal. is a hack.
          duration: parseInt((ui.size.height + 59) / 60) * 60,
          hour: $(this).closest('tr.hour-row').data('hour'),
          slot: $(this).closest('.slot').data('slot')
        }

$ ->
  $('.delete-appointment').click ->
    $.ajax "/appointments/destroy",
      type: 'POST',
      data: {
        # TODO can not mix data and attr together because of caching in jQuery.
        # Investigate what are the best pratices
        appointment_id: $('.appointment-dialog').attr('data-appointment')
      }
      error: ->
        #alert 'error' # TODO: added generic error handler
        #
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
  $('.appointment-dialog').css('visibility', 'hidden')
  $('#active-hour').removeAttr('id')

(exports ? this).ResetClientAppointmentDialog = ->
    $('.client-search-results').empty()
    $('.search-client').val('')
    $('.first-name').val('')
    $('.last-name').val('')
    $('.email').val('')
    $('.telephone-cellular').val('')
    $('.appointment-dialog-error').css('display', 'none')

$ ->
  $('.show-client-details').click ->
    ShowClientAppointmentDetailsPartial()

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

$ ->
  # TODO can this be added to the html as a jquery-ujs attribute? such as data-keyup?
  $('.search-client').keyup ->
    $.ajax "/clients/search",
      type: 'GET',
      data: { term: $(this).val() }
      error: ->
        #alert 'error' # TODO: added generic error handler


$ -> InstallClientAppointmentHandler()
$ -> InstallShowClientAppointmentDialogHandler()

