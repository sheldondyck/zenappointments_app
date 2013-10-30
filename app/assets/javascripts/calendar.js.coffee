# startOfWeek: Sunday = 0, ... Saturday = 6
(exports ? this).buildCal = (m, y, startOfWeek = 0) ->
  mn = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  dim = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  oPM = new Date(y, m - 2, 1)
  oNM = new Date(y, m, 1)
  oD = new Date(y, m - 1, 1)

  if oD.getDay() + 1 - startOfWeek == 0
    oD.od = oD.getDay() + 1 - startOfWeek + 7
  else
    oD.od = oD.getDay() + 1 - startOfWeek

  todaydate = new Date()
  scanfortoday = formatISODate(todaydate)
  dim[1] = (if (((oD.getFullYear() % 100 isnt 0) and (oD.getFullYear() % 4 is 0)) or (oD.getFullYear() % 400 is 0)) then 29 else 28)
  t = "<table class='calendar-mini' cols='7'><tr>"
  t += "<td colspan='7'><div data-previous-date='" + formatISODate(oPM) + "' class='calendar-mini-previous-month'><i class='fa fa-chevron-left'/></div>" + mn[m - 1] + " " + y + "<div data-next-date='" + formatISODate(oNM) + "' class='calendar-mini-next-month'><i class='fa fa-chevron-right'/></div></td></tr><tr>"
  s = 0

  while s < 7
    t += "<th>" + "SMTWTFSSMTWTFS".substr(s + startOfWeek, 1) + "</th>"
    s++

  t += "</tr><tr>"
  i = 1
  f = false

  while i <= 42 and !f
    oCD = new Date(y, m - 1, i - oD.od + 1)
    klass = ""
    klass = " today " if formatISODate(oCD) == scanfortoday
    klass += " weekend" if oCD.getDay() == 0 or oCD.getDay() == 6
    klass += " notmonth " + scanfortoday if !((i - oD.od >= 0) and (i - oD.od < dim[m - 1]))
    t += "<td class='day" + klass + "' data-date='" + formatISODate(oCD) + "'>" + linkTo(oCD) + "</td>"
    f = true if ((i) % 7 == 0) and ((i - oD.od + 1) >= dim[m - 1])

    if !f
      t += "</tr><tr>" if ((i) % 7 == 0) and (i < 36)
      i++
    else
      t += "</tr>"

  t += "</tr></table>"

formatISODate = (oDate) ->
  # TODO should format as YYYY-MM-DD not YYYY-M-D
  month = oDate.getMonth() + 1
  return oDate.getFullYear() + "-" + month + "-" + oDate.getDate()

linkTo = (oDate) ->
  return "<a href='/appointments?date=" + formatISODate(oDate) + "' data-remote='true'>" + oDate.getDate() + "</a>"

jQuery ->
  showCalendarMini()

(exports ? this).showCalendarMini = (date = new Date())->
  curMonth = date.getMonth() + 1
  curYear = date.getFullYear()

  if $('.calendar-mini-js').length > 0
    # TODO: need to add support for Account.start_of_week
    $('.calendar-mini-js').html(buildCal(curMonth, curYear, 1))

    $('.calendar-mini-previous-month').click ->
      showCalendarMini(new Date($(this).data('previous-date')))

    $('.calendar-mini-next-month').click ->
      showCalendarMini(new Date($(this).data('next-date')))

      #$('.calendar-mini-js td.day').click ->
      #alert $(this).data('date')
