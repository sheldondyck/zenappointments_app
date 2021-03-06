# TODO agenda_help week_helper calendar_help should be combined

module WeekHelper
  def week(date = Date.today, &block)
    Week.new(self, date, block).table
  end

  class Week < Struct.new(:view, :date, :callback)
    delegate :content_tag, to: :view

    def table
      content_tag :table, class: 'week minutes', data: { slots: Account.slots_per_hour, minutes: Account.minutes_per_slot } do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        content_tag :th, class: 'corner' do
          weeks.map do |week|
            week.map do |day|
              # TODO this is duplicated in th col. how do we get this in onclick?
              content_tag :th, class: 'day-col', data: { weekday: day.strftime('%A') } do
                # TODO boo! rails does have routing in helpers
                #content_tag :a, day.strftime('%A - %m/%e'), href: appointment_path(view: 'day', date: day)
                content_tag :a, day.strftime('%A - %m/%e'),
                  href: "/appointments?view=day&date=#{day.strftime('%Y-%m-%d')}",
                  data: { remote: true }
              end
            end.join.html_safe
          end.join.html_safe
        end
      end
    end

    def week_rows
      hours.map do |hour|
        content_tag :tr, class: 'hour-row', data: hour_row_data(hour) do
          hour_row_header(hour).html_safe +
          weeks.map do |week|
            week.map do |day|
              hour_cell(day, hour)
            end
          end.join.html_safe
        end
      end.join.html_safe
    end

    def hour_row_data(hour)
      data = {
        hour: hour,
        # TODO this cal. is duplicated in card.html.
        interval: "#{hour}:00 - #{hour + 1}:00",
        # TODO magic number duration here. should be dynamical
        duration: Account.appointment_duration
      }
    end

    def hour_row_header(hour)
      content_tag :td, '%2d:00' % hour, class: 'hour-header'
    end

    def hour_row_class(hour)
      classes = []
      classes << 'hour'
      classes.empty? ? nil : classes.join(" ")
    end

    def hour_cell(day, hour)
      content_tag :td, class: hour_class(day, hour), data: hour_data(day, hour) do
        appointment_slots(day, hour)
      end
    end

    def hour_class(day, hour)
      classes = []
      classes << 'hour'
      #classes << "today" if day == Date.today
      classes << "weekend" if (day.saturday? || day.sunday?)
      #classes << 'hour-' + hour.to_s
      #classes << "today" if day == Date.today
      #classes << "notmonth" if day.month != date.month
      #classes << 'edit-day'
      classes.empty? ? nil : classes.join(" ")
    end

    def hour_data(day, hour)
      data = {
        # TODO should be removed. since is duplicated in the header th
        weekday: day.strftime('%A'),
        date: day.to_s,
        # TODO this format is duplicated in controller
        date_pretty: day.strftime('%B %e %Y')
      }
    end

    def appointment_slots(day, hour)
      (0...Account.slots_per_hour).map do |slot|
        content_tag :div,
          view.capture(day, hour, slot, Account.minutes_per_slot, &callback),
          class: appointment_slot_class(slot),
          data: appointment_slot_data(slot)
      end.join.html_safe
    end

    def appointment_slot_class(slot)
      classes = []
      classes << "slot"
      classes << "slot-#{Account.slots_per_hour}-#{slot}"
      classes.join(" ")
    end

    def appointment_slot_data(slot)
      data = {
        slot: slot
      }
    end

    def weeks
      first = date.beginning_of_week(Account.start_of_week)
      last = date.end_of_week(Account.start_of_week)
      (first..last).to_a.in_groups_of(7)
    end

    def hours
      (Account.starting_hour..Account.ending_hour).to_a
    end
  end
end
