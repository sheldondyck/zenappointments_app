$ ->
  $(".show-hide-password").each (index, input) ->
    $input = $(input)
    $(".btn-show-hide-password").click ->
      change = ""
      # TODO How will this be localized to portugues since we are using Show/Hide as a boolean
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
        .attr("placeholder", $input.attr("placeholder"))
        .val($input.val())
        .insertBefore($input)
      $input.remove()
      $input = rep
      $input.append('span.input-group-btn#password')
