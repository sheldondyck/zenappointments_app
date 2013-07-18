class AppointmentsController < ApplicationController
  before_action :authorize_user

  NAV_TITLE = {day: '%A, %B %e %Y', week: 'week %V - %Y', weeks2: 'week2 %Y', month: '%B %Y', months2: 'Months 2 %B %Y', year: '%Y', years2: '%Y - %Y 2'}

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @view = params[:view] ||= 'day'
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    @employees = [2, 4, 102]
  end

  def change
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @view = params[:view] ||= 'day'
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    @employees = [2, 4, 102]
  end

  private
    def authorize_user
      redirect_to signin_path, notice: 'Access restricted, please login' unless signed_in?
    end
end
