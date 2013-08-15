module WeekHelper
  def week(date = Date.today, &block)
    Week.new(self, date, block).table
  end

  class Week < Struct.new(:view, :date, :callback)
    HEADER = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    START_DAY = :sunday
    FIRST_HOUR = 7
    LAST_HOUR = 19

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "agenda" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        content_tag(:th, '', class: 'corner').html_safe +
        HEADER.map { |day| content_tag :th, day }.join.html_safe
      end
    end

    def week_rows
      hours.map do |hour|
        content_tag :tr do
          hour_cell(hour).html_safe +
          weeks.map do |week|
            week.map do |day|
              appointment_cell(day, hour)
            end.join.html_safe
          end.join.html_safe
        end
      end.join.html_safe
    end

    def hour_cell(hour)
      content_tag :td, '%02d:00' % hour, class: hour_classes(hour)
    end

    def appointment_cell(day, hour)
      content_tag :td, view.capture(day, hour, &callback), class: appointment_classes(hour)
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
      classes << 'hour-' + hour.to_s
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
