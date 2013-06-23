class AppointmentsController < ApplicationController
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @view = params[:view]
  end

  def change
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @view = params[:view]
  end

  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @view = params[:view]
  end
end
