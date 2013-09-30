#jQuery ->
  #$('.show-hide-password').click ->
    #$('#password').type = 'text'
    #$('#email').visibility = 'hidden'
    #$('.password').visibility = 'hidden'
    #alert 'pasword ' + $('input#password').val()

$ ->
  $(".show-hide-password").each (index, input) ->
    $input = $(input)
    #alert 'each '
    $(".btn-show-hide-password").click(->
      #alert 'click'
      change = ""
      if $(this).html() is "Show"
        $(this).html "Hide"
        change = "text"
      else
        $(this).html "Show"
        change = "password"
      rep = $("<input type='" + change + "' />")
        .attr("id", $input.attr("id"))
        .attr("name", $input.attr("name"))
        .attr("class", $input.attr("class"))
        .val($input.val())
        .insertBefore($input)
      $input.remove()
      $input = rep
      ).insertAfter $input
