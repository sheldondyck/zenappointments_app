class AppointmentsController < ApplicationController
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
