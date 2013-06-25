jQuery.fn.activateDayViewModule = ->
  @find('.edit_hour').click ->
    #alert 'foo'
    $(this).css('background-color', '#0d0')
    $(this).append('<div>hello world</div>')
  this
