class DashboardController < ApplicationController
  prepend_before_action :authorize_user
  respond_to :json, :html

  def index
    @title = @current_user.name
    # TODO is Date.parse in current time zone? If not add.
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @appointment_activity = Appointment.select("date(time) as time, count(*) as cnt").where(time: (@date.in_time_zone - 60.days)..(@date.in_time_zone + 60.days)).group("date(time)").order("date(time)").count(:time)
  end
end
