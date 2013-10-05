# TODO agenda_help week_helper calendar_help should be combined
module AgendaHelper
  def agenda(date = Date.today, employees = [], &block)
    Agenda.new(self, date, employees, block).table
  end

  class Agenda < Struct.new(:view, :date, :employees, :callback)
    # TODO duplicated in week_helper
    FIRST_HOUR = 0
    LAST_HOUR = 24
    APPOINTMENT_SLOTS = 4
    APPOINTMENT_DURATION = 60
    SLOT_DURATION = 60 / APPOINTMENT_SLOTS

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: 'agenda' do
        header + hour_rows
      end
    end

    def header
      content_tag :tr do
        content_tag(:th, '', class: 'corner').html_safe +
        employees.map do |employee|
          content_tag :th, 'Employee #' + employee.to_s
        end.join.html_safe
      end
    end

    def hour_rows
      hours.map do |hour|
        content_tag :tr, class: 'hour-row', data: hour_row_data(hour) do
          hour_row_cell(hour).html_safe +
          employees.map do |employee|
            employee_cell(employee, hour, APPOINTMENT_DURATION)
          end.join.html_safe
        end
      end.join.html_safe
    end

    def hour_row_class(hour)
      classes = []
      classes << 'hour'
      classes.empty? ? nil : classes.join(' ')
    end

    def hour_row_cell(hour)
      content_tag :td, '%02d:00' % hour, class: hour_row_class(hour)
    end

    def hour_row_data(hour)
      data = {
        hour: hour,
        # TODO this cal. is duplicated in card.html.
        interval: "#{hour}:00 - #{hour + 1}:00",
        duration: APPOINTMENT_DURATION }
    end

    def employee_cell(employee, hour, duration)
      content_tag :td, class: employee_class(hour), data: employee_data(date) do
        appointment_slots(date, hour)
      end
    end

    def employee_class(hour)
      classes = []
      classes << 'edit-hour'
      # TODO: OK to remove "hour-n"?
      #classes << 'hour-' + hour.to_s
      classes.empty? ? nil : classes.join(' ')
    end

    def employee_data(date)
      # TODO: code smell
      # 2 date_pretty formatting is duplicated in controller
      # 3. duplicate in week_agenda
      data = {
        # TODO should be removed. since is duplicated in the header th
        weekday: date.strftime('%A'),
        date: date.to_s,
        # TODO this format is duplicated in controller
        date_pretty: date.strftime('%B %e %Y') }
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

    def hours
      first = FIRST_HOUR
      last = LAST_HOUR
      (first..last).to_a
    end
  end
end
