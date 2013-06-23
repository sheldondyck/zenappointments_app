class AppointmentsController < ApplicationController
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def change
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
