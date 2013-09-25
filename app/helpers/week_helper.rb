# TODO agenda_help week_helper calendar_help should be combined
module WeekHelper
  def week(date = Date.today, &block)
    Week.new(self, date, block).table
  end

  class Week < Struct.new(:view, :date, :callback)
    START_DAY = :sunday
    FIRST_HOUR = 0
    LAST_HOUR = 24

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "week" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        content_tag(:th, '', class: 'corner').html_safe +
        weeks.map do |week|
          week.map do |day|
            content_tag :th, day.strftime('%A'),
              class: 'day-col',
              data: {
                weekday: day.strftime('%A') # TODO this is duplicated in th col. how do we get this in onclick?
              }
          end.join.html_safe
        end.join.html_safe
      end
    end

    def week_rows
      "<div class='hour-grid'>".html_safe +
      hours.map do |hour|
        content_tag :tr,
          class: 'hour-row',
          data: {
            hour: hour,
            interval: "#{hour}:00 - #{hour + 1}:00", # TODO this cal. is duplicated in card.html.
            duration: 60 # TODO magic number duration here. should be dynamical
          } do
          hour_cell(hour, 60).html_safe +
          weeks.map do |week|
            week.map do |day|
              appointment_cell(day, hour)
            end.join.html_safe
          end.join.html_safe
        end
      end.join.html_safe +
      "</div>".html_safe
    end

    def hour_cell(hour, duration)
      content_tag :td, '%02d:00' % hour, class: hour_classes(hour)
    end

    def appointment_cell(day, hour)
      content_tag :td, view.capture(day, hour, &callback),
        class: appointment_classes(hour),
        data: {
          weekday: day.strftime('%A'), # TODO should be removed. since is duplicated in the header th
          date: day.to_s,
          date_pretty: day.strftime('%B %e %Y') # TODO this format is duplicated in controller
        }
    end

    def hour_classes(hour)
      classes = []
      classes << 'hour'
      #classes << "today" if day == Date.today
      #classes << "notmonth" if day.month != date.month
      #classes << 'edit-day'
      classes.empty? ? nil : classes.join(" ")
    end

    def appointment_classes(hour)
      classes = []
      classes << 'edit-hour'
      #classes << 'hour-' + hour.to_s
      #classes << "today" if day == Date.today
      #classes << "notmonth" if day.month != date.month
      #classes << 'edit-day'
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.beginning_of_week(START_DAY)
      last = date.end_of_week(START_DAY)
      (first..last).to_a.in_groups_of(7)
    end

    def hours
      first = FIRST_HOUR
      last = LAST_HOUR
      (first..last).to_a
    end
  end
end
