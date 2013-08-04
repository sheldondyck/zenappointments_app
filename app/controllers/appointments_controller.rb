class AppointmentsController < ApplicationController
  before_action :authorize_user

  NAV_TITLE = {day: '%A, %B %e %Y', week: 'week %V - %Y', weeks2: 'week2 %Y', month: '%B %Y', months2: 'Months 2 %B %Y', year: '%Y', years2: '%Y - %Y 2'}

  def index
    @title = @current_user.name
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

  def create
    puts 'CREATE!!!'
    @client = Client.find_or_create_by(email: 'foo@boo.com')
   # , client_params.merge(account_id: @current_user.account_id))
    #@client.save
    puts 'CREATE 2!!!'
    puts @client.id
    @appointment = Appointment.new(appointment_params.merge(account_id: @current_user.account_id,
                                                            user_id: @current_user.id,
                                                            client_id: @client.id))
    @appointment.save
  end

  private
    def client_params
      params.require(:appointment).permit(:first_name,
                                           :last_name,
                                           :telefone_celular)
    end

    def appointment_params
      params.require(:appointment).permit(:time, :duration)
    end
end
