class AppointmentsController < ApplicationController
  NAV_TITLE = {day: 'day %Y', week: 'week %Y', weeks2: 'week2 %Y', month: '%B %Y', months2: 'Months 2 %B %Y', year: '%Y', years2: '%Y - %Y 2'}

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @view = params[:view] ||= 'month'
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
  end

  def change
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @view = params[:view] ||= 'month'
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
  end
end
