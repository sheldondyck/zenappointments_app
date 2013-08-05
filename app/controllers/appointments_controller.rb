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
    puts 'CHANGE'
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @view = params[:view] ||= 'day'
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    @employees = [2, 4, 102]
  end

  def create
    begin
      puts 'CREATE'
      #puts params.require(:appointment).permit(:email).to_yaml
      #puts client_params.merge(account_id: @current_user.account_id).to_yaml

      @client = Client.find_by(params.require(:appointment).permit(:email))
      puts 'CREATE 1a!!!'
      puts @client.to_yaml
      @client = Client.create(client_params.merge(account_id: @current_user.account_id)) if @client.nil?
      puts 'CREATE 1b!!!'
      puts @client.to_yaml
      @client = Client.find_by(params.require(:appointment).permit(:email))

      #@client = Client.find_or_create_by(params.require(:appointment).permit(:email)) do |client|
        #client.account_id = @current_user.account_id
        #client.first_name = params.require(:appointment).permit(:first_name)
        #client.first_name = params[:first_name]
      #end

      puts 'CREATE 2!!!'
      puts @client.to_yaml
      puts 'CREATE 2a!!!'
      puts appointment_params.merge(account_id: @current_user.account_id,
                               user_id: @current_user.id,
                               client_id: @client.id).to_yaml

      @appointment = Appointment.new(appointment_params.merge(account_id: @current_user.account_id,
                                                              user_id: @current_user.id,
                                                              client_id: @client.id))
      puts 'CREATE 3!!!'
      puts @appointment.to_yaml
      @appointment.save
      puts 'CREATE 4!!!'
      puts @appointment.to_yaml
    rescue
    end
  end

  private
    def client_params
      params.require(:appointment).permit(:first_name,
                                           :last_name,
                                           :telephone_celular,
                                           :email)
    end

    def appointment_params
      params.require(:appointment).permit(:time, :duration)
    end
end
