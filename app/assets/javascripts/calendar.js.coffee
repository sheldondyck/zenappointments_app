(exports ? this).buildCal = (m, y, cM, cH, cDW, cD, brdr) ->
  #alert 'buildCal'
  mn = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  dim = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  oD = new Date(y, m - 1, 1) #DD replaced line to fix date bug when current day is 31st
  oD.od = oD.getDay() + 1 #DD replaced line to fix date bug when current day is 31st
  todaydate = new Date() #DD added
  scanfortoday = (if (y is todaydate.getFullYear() and m is todaydate.getMonth() + 1) then todaydate.getDate() else 0) #DD added
  dim[1] = (if (((oD.getFullYear() % 100 isnt 0) and (oD.getFullYear() % 4 is 0)) or (oD.getFullYear() % 400 is 0)) then 29 else 28)
  t = "<div class=\"" + cM + "\"><table class=\"" + cM + "\" cols=\"7\" cellpadding=\"0\" border=\"" + brdr + "\" cellspacing=\"0\"><tr align=\"center\">"
  t += "<td colspan=\"7\" align=\"center\" class=\"" + cH + "\">" + mn[m - 1] + " - " + y + "</td></tr><tr align=\"center\">"
  s = 0
  while s < 7
    t += "<td class=\"" + cDW + "\">" + "SMTWTFS".substr(s, 1) + "</td>"
    s++
  t += "</tr><tr align=\"center\">"
  i = 1
  while i <= 42
    x = (if ((i - oD.od >= 0) and (i - oD.od < dim[m - 1])) then i - oD.od + 1 else "&nbsp;")
    #DD added
    x = "<span id=\"today\">" + x + "</span>"  if x is scanfortoday #DD added
    t += "<td class=\"" + cD + "\">" + x + "</td>"
    t += "</tr><tr align=\"center\">"  if ((i) % 7 is 0) and (i < 36)
    i++
  t += "</tr></table></div>"

jQuery ->
  $('.calendar-mini-js').ready = ->
    alert 'oi mini'

$ ->
  $(document).ready = ->
    alert 'oi mini 2'

jQuery ->
  foo()

(exports ? this).foo = ->
  todaydate=new Date()
  curmonth=todaydate.getMonth()+1  #get current month (1-12)
  curyear=todaydate.getFullYear() #get current year

  $('.calendar-mini-js').append(buildCal(curmonth ,curyear, "main", "month", "daysofweek", "days", 1))

