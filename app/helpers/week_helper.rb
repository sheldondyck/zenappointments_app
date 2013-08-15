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
      content_tag :table, class: "calendar" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER.map { |day| content_tag :th, day }.join.html_safe
      end
    end

    def week_rows
      hours.map do |hour|
        content_tag :tr do
          weeks.map do |week|
            week.map do |day|
              hour_cell(day, hour)
            end.join.html_safe
          end.join.html_safe
        end
      end.join.html_safe
    end

    def hour_cell(day, hour)
      content_tag :td, view.capture(day, hour, &callback), class: hour_classes(day)
    end

    def hour_classes(day)
      classes = []
      classes << "today" if day == Date.today
      classes << "notmonth" if day.month != date.month
      classes << 'edit-day'
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
