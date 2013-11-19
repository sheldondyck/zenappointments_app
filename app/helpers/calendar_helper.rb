# TODO agenda_help week_helper calendar_help should be combined
module CalendarHelper
  def calendar(mini, date = Date.today, &block)
    Calendar.new(self, date, mini, block).table
  end

  class Calendar < Struct.new(:view, :date, :mini, :callback)
    delegate :content_tag, to: :view

    def table
      content_tag :table, class: mini ? 'calendar-mini' : 'calendar' do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        header_weeks.map do |week|
          week.map do |day|
            # TODO yuck. find 'railsway'(tm) for this
            content_tag :th, mini ? day.strftime('%a')[0,1] : day.strftime('%A')
          end.join.html_safe
        end.join.html_safe
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
      content_tag :td, view.capture(day, &callback), class: day_classes(day), data: day_data(day)
    end

    def day_classes(day)
      classes = []
      classes << 'mini' if mini
      classes << 'today' if day == Date.today
      classes << 'notmonth' if day.month != date.month
      classes << 'weekend' if (day.saturday? || day.sunday?)
      classes << 'jump-appointment'
      classes.empty? ? nil : classes.join(' ')
    end

    def day_data(day)
      data = {
        date: day.to_s
      }
    end

    def header_weeks
      first = date.beginning_of_week(Account.start_of_week)
      last = date.end_of_week(Account.start_of_week)
      (first..last).to_a.in_groups_of(7)
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(Account.start_of_week)
      last = date.end_of_month.end_of_week(Account.start_of_week)
      (first..last).to_a.in_groups_of(7)
    end
  end
end
