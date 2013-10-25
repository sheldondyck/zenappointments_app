(exports ? this).buildCal = (m, y) ->
  # TODO: need to add support for Account.start_of_week
  mn = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  dim = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  oPM = new Date(y, m - 2, 1)
  oNM = new Date(y, m, 1)
  oD = new Date(y, m - 1, 1)
  oD.od = oD.getDay() + 1
  todaydate = new Date()
  scanfortoday = (if (y == todaydate.getFullYear() and m == todaydate.getMonth() + 1) then todaydate.getDate() else NaN)
  dim[1] = (if (((oD.getFullYear() % 100 isnt 0) and (oD.getFullYear() % 4 is 0)) or (oD.getFullYear() % 400 is 0)) then 29 else 28)
  t = "<div class='calendar-mini'><table cols='7'><tr>"
  t += "<td colspan='7'><div data-date='" + oPM.toISOString() + "' class='calendar-mini-previous-month'><i class='fa fa-chevron-left'/></div>" + mn[m - 1] + " " + y + "<div data-date='" + oNM.toISOString() + "' class='calendar-mini-next-month'><i class='fa fa-chevron-right'/></div></td></tr><tr>"
  s = 0
  while s < 7
    t += "<th>" + "SMTWTFS".substr(s, 1) + "</th>"
    s++
  t += "</tr><tr>"
  i = 1
  f = false
  while i <= 42 and !f
    weekend = ""
    x = (if ((i - oD.od >= 0) and (i - oD.od < dim[m - 1])) then i - oD.od + 1 else (i - oD.od + 1))
    oCD = new Date(y, m - 1, x)

    if x == scanfortoday
      today = " today"
    else
      today = ""

    if (oCD.getDay() == 0 or oCD.getDay() == 6 )
      weekend = " weekend"
    else
      weekend = ""

    if ((i - oD.od >= 0) and (i - oD.od < dim[m - 1]))
      t += "<td class='day" + today + weekend + "'>" + x + "</td>"
    else
      if (i - oD.od >= 0)
        f = true if ((i) % 7 is 0) and (i < 36)
        nn = i - oD.od - dim[m - 1] + 1
        t += "<td class='day notmonth" + today + weekend + "'>" + nn + "</td>"
      else
        pn = dim[m - 1] + x - 1
        t += "<td class='day notmonth" + today + weekend + "'>" + pn + "</td>"

    if !f
      t += "</tr><tr>"  if ((i) % 7 is 0) and (i < 36)
    else
      t += "</tr>"

    i++
  t += "</tr></table></div>"

jQuery ->
  showCalendarMini()

(exports ? this).showCalendarMini = (date = new Date())->
  curmonth = date.getMonth() + 1
  curyear = date.getFullYear()

  if $('.calendar-mini-js').length > 0
    $('.calendar-mini-js').html(buildCal(curmonth, curyear))

    $('.calendar-mini-previous-month').click ->
      showCalendarMini(new Date($(this).data('date')))

    $('.calendar-mini-next-month').click ->
      showCalendarMini(new Date($(this).data('date')))

      #$('.calendar-mini-js td.day').click ->
      #alert $(this).html()
