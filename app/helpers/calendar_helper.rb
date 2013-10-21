# TODO agenda_help week_helper calendar_help should be combined
module CalendarHelper
  def calendar(klass, date = Date.today, &block)
    Calendar.new(self, date, block).table(klass)
  end

  class Calendar < Struct.new(:view, :date, :callback)
    HEADER = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    HEADER_COMPACT = %w[S M T W T F S]
    # TODO: should we get this value from Account.start_of_week?
    START_DAY = :sunday

    delegate :content_tag, to: :view

    def table(klass)
      content_tag :table, class: klass do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER_COMPACT.map { |day| content_tag :th, day }.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        content_tag :tr do
          week.map { |day| day_cell(day) }.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      content_tag :td, view.capture(day, &callback), class: day_classes(day)
    end

    def day_classes(day)
      classes = []
      classes << "today" if day == Date.today
      classes << "notmonth" if day.month != date.month
      classes << 'edit-day'
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      last = date.end_of_month.end_of_week(START_DAY)
      (first..last).to_a.in_groups_of(7)
    end
  end
end
