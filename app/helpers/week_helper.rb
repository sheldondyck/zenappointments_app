# TODO agenda_help week_helper calendar_help should be combined
module WeekHelper
  def week(date = Date.today, &block)
    Week.new(self, date, block).table
  end

  class Week < Struct.new(:view, :date, :callback)
    START_DAY = :sunday
    # TODO duplicated in agenda_helper
    APPOINTMENT_SLOTS = 4
    FIRST_HOUR = 0
    LAST_HOUR = 24
    APPOINTMENT_DURATION = 60
    SLOT_DURATION = 60 / APPOINTMENT_SLOTS

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "week" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        content_tag :th, class: 'corner' do
          weeks.map do |week|
            week.map do |day|
              content_tag :th, day.strftime('%A'),
                class: 'day-col',
                 # TODO this is duplicated in th col. how do we get this in onclick?
                data: { weekday: day.strftime('%A') }
            end.join.html_safe
          end.join.html_safe
        end
      end
    end

    def week_rows
      content_tag :div, class: 'hour-grid' do
        hours.map do |hour|
          content_tag :tr, class: 'hour-row', data: hour_row_data(hour) do
            hour_row_cell(hour, APPOINTMENT_DURATION).html_safe +
            weeks.map do |week|
              week.map do |day|
                hour_cell(day, hour)
              end
            end.join.html_safe
          end
        end.join.html_safe
      end
    end

    def hour_row_data(hour)
      data = {
        hour: hour,
        # TODO this cal. is duplicated in card.html.
        interval: "#{hour}:00 - #{hour + 1}:00",
        # TODO magic number duration here. should be dynamical
        duration: APPOINTMENT_DURATION }
    end

    def hour_row_cell(hour, duration)
      content_tag :td, '%02d:00' % hour, class: hour_row_class(hour)
    end

    def hour_row_class(hour)
      classes = []
      classes << 'hour'
      #classes << "today" if day == Date.today
      #classes << "notmonth" if day.month != date.month
      #classes << 'edit-day'
      classes.empty? ? nil : classes.join(" ")
    end

    def hour_cell(day, hour)
      content_tag :td, class: hour_class(hour), data: hour_data(day, hour) do
        appointment_slots(day, hour)
      end
    end

    def hour_class(hour)
      classes = []
      classes << 'edit-hour'
      #classes << 'hour-' + hour.to_s
      #classes << "today" if day == Date.today
      #classes << "notmonth" if day.month != date.month
      #classes << 'edit-day'
      classes.empty? ? nil : classes.join(" ")
    end

    def hour_data(day, hour)
      data = {
        # TODO should be removed. since is duplicated in the header th
        weekday: day.strftime('%a'),
        date: day.to_s,
        # TODO this format is duplicated in controller
        date_pretty: day.strftime('%b %e %y') }
    end

    def appointment_slots(day, hour)
      (0...APPOINTMENT_SLOTS).map do |slot|
        content_tag :div,
          view.capture(day, hour, slot, SLOT_DURATION, &callback),
          class: appointmet_slot_class(slot)
      end.join.html_safe
    end

    def appointmet_slot_class(slot)
      classes = []
      classes << "slot"
      classes << "slot-#{slot}"
      classes.join(" ")
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
