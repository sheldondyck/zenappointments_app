# startOfWeek: Sunday = 0, ... Saturday = 6
#
buildCal = (y, m, startOfWeek = 0) ->
  mn = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  dim = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  #alert 'y: ' + y + ' m: ' + m

  # TODO: we had to use day: 15 here because of timezone problems.
  # testing when the day was 1-12-2013 caused problems since the day would get moved to 30
  # and month 11. Using 15 is a hack since we only need the year and month here.
  # SOLUTION: start using time_zone info from account config for all javascript Dates.
  if m == 1
    oPM = new Date(y - 1, 11, 15)
  else
    oPM = new Date(y, m - 2, 15)

  if m == 12
    oNM = new Date(y + 1, 0, 15)
  else
    oNM = new Date(y, m, 15)

  oD = new Date(y, m - 1, 15)

  nM = oD.getMonth() + 1

  if oD.getDay() + 1 - startOfWeek == 0
    oD.od = oD.getDay() + 1 - startOfWeek + 7
  else
    oD.od = oD.getDay() + 1 - startOfWeek

  #alert 'nm: ' + formatISODate(oNM)

  todaydate = new Date()
  scanfortoday = formatISODate(todaydate)
  dim[1] = (if (((oD.getFullYear() % 100 isnt 0) and (oD.getFullYear() % 4 is 0)) or (oD.getFullYear() % 400 is 0)) then 29 else 28)
  t = "<table class='calendar-mini' cols='7' data-year='" + oD.getFullYear() + "' data-month='" + nM + "'><tr>"
  t += "<td colspan='7'><div data-previous-date='" + formatISODate(oPM) + "' class='calendar-mini-previous-month'><i class='fa fa-chevron-left'/></div>"
  t += mn[m - 1] + " " + y
  t += "<div data-next-date='" + formatISODate(oNM) + "' class='calendar-mini-next-month'><i class='fa fa-chevron-right'/></div></td></tr><tr>"
  s = 0

  while s < 7
    t += "<th>" + "SMTWTFSSMTWTFS".substr(s + startOfWeek, 1) + "</th>"
    s++

  t += "</tr><tr>"
  i = 1
  f = false

  while i <= 42 and !f
    oCD = new Date(y, m - 1, i - oD.od + 1)
    sCD = formatISODate(oCD)
    klass = " date-"
    klass += sCD
    klass = " today " if sCD == scanfortoday
    klass += " weekend" if oCD.getDay() == 0 or oCD.getDay() == 6
    klass += " notmonth " + scanfortoday if !((i - oD.od >= 0) and (i - oD.od < dim[m - 1]))
    t += "<td class='day" + klass + "' data-date='" + sCD + "'>" + linkTo(oCD) + "</td>"
    f = true if ((i) % 7 == 0) and ((i - oD.od + 1) >= dim[m - 1])

    if !f
      t += "</tr><tr>" if ((i) % 7 == 0) and (i < 36)
      i++
    else
      t += "</tr>"

  t += "</tr></table>"

leadingZero = (n) ->
  z = ""
  if ( n < 10 )
    z = "0" + n
  else
    z = n

  return z

formatISODate = (oDate) ->
  return oDate.getFullYear() + "-" + leadingZero(oDate.getMonth() + 1) + "-" + leadingZero(oDate.getDate())

linkTo = (oDate) ->
  return "<a href='/appointments?date=" + formatISODate(oDate) + "' data-remote='true'>" + oDate.getDate() + "</a>"

jQuery ->
  showSidebarCalendar()

showSidebarCalendar = (date = new Date())->
  curMonth = date.getMonth() + 1
  curYear = date.getFullYear()
  #alert 'show cal: ' + formatISODate(date) + ' curYear: ' + curYear  + ' curMonth: ' + curMonth

  if $('.calendar-mini-js').length > 0
    # TODO: need to add support for Account.start_of_week
    $('.calendar-mini-js').html(buildCal(curYear, curMonth, 1))

    $('.calendar-mini-previous-month').click ->
      showSidebarCalendar(new Date($(this).data('previous-date')))

    $('.calendar-mini-next-month').click ->
      #alert 'next: ' + $(this).data('next-date')
      showSidebarCalendar(new Date($(this).data('next-date')))

(exports ? this).updateSidebarCalendar = (y, m, d, mode) ->
  oCD = new Date(y, parseInt(m) - 1, d)

  #alert 'month: ' + $('.calendar-mini').data('month') + " m: " + parseInt(m)

  if $('.calendar-mini').length > 0
    if $('.calendar-mini').data('month') != parseInt(m)
      showSidebarCalendar(oCD)

  $('.calendar-mini-js').find('*#active-day').removeAttr('id')

  if mode == 'day'
    #alert 'sidebar calendar date: ' + formatISODate(oCD) + ' mode: ' + mode
    $('.date-' + formatISODate(oCD)).attr('id', 'active-day')
  else if mode == 'week'
    i = 0
    while i < 7
      oCD = new Date(y, parseInt(m) - 1, parseInt(d) + i)
      #alert 'sidebar calendar date: ' + formatISODate(oCD) + ' mode: ' + mode
      $('.date-' + formatISODate(oCD)).attr('id', 'active-day')
      ++i
  else if mode == 'month'
    i = 0
    while i < 31
      oCD = new Date(y, parseInt(m) - 1, 1 + i)
      #alert 'sidebar calendar date: ' + formatISODate(oCD) + ' mode: ' + mode

      if oCD.getMonth() + 1 == parseInt(m)
        $('.date-' + formatISODate(oCD)).attr('id', 'active-day')

      ++i
