# TODO agenda_help week_helper calendar_help should be combined
module AgendaHelper
  def agenda(date = Date.today, employees = [], &block)
    Agenda.new(self, date, employees, block).table
  end

  class Agenda < Struct.new(:view, :date, :employees, :callback)
    FIRST_HOUR = 0
    LAST_HOUR = 24

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: 'agenda' do
        header + hour_rows
      end
    end

    def header
      content_tag :tr do
        content_tag(:th, '', class: 'corner').html_safe +
        employees.map { |employee| content_tag :th, 'Employee #' + employee.to_s }.join.html_safe
      end
    end

    def hour_rows
      hours.map do |hour|
        content_tag :tr,
          class: 'hour-row',
          data: {
            hour: hour,
            interval: "#{hour}:00 - #{hour + 1}:00", # TODO this cal. is duplicated in card.html.
            duration: 60 # TODO magic number duration here. should be dynamical
          } do
          hour_cell(hour).html_safe +
          employees.map { |employee| employee_cell(employee, hour, 60) }.join.html_safe
        end
      end.join.html_safe
    end

    def hour_cell(hour)
      content_tag :td, '%02d:00' % hour, class: hour_classes(hour)
    end

    def employee_cell(employee, hour, duration)
      # TODO: code smell
      # 1. too long
      # 2 date_pretty formatting is duplicated in controller
      # 3. duplicate in week_agenda
      content_tag :td, view.capture(employee, hour, &callback),
        class: employee_classes(hour),
        data: {
          weekday: date.strftime('%A'), # TODO should be removed. since is duplicated in the header th
          date: date.to_s,
          date_pretty:  date.strftime('%B %e %Y') # TODO this format is duplicated in controller
        }
    end

    def hour_classes(hour)
      classes = []
      classes << 'hour'
      classes.empty? ? nil : classes.join(' ')
    end

    def employee_classes(hour)
      classes = []
      classes << 'edit-hour'
      # TODO: OK to remove "hour-n"?
      #classes << 'hour-' + hour.to_s
      classes.empty? ? nil : classes.join(' ')
    end

    def hours
      first = FIRST_HOUR
      last = LAST_HOUR
      (first..last).to_a
    end
  end
end
