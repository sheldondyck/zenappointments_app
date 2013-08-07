class AppointmentsController < ApplicationController
  before_action :authorize_user
  respond_to :json, :html

  NAV_TITLE = {day: '%A, %B %e %Y', week: 'week %V - %Y', weeks2: 'week2 %Y', month: '%B %Y', months2: 'Months 2 %B %Y', year: '%Y', years2: '%Y - %Y 2'}

  def index
    @title = @current_user.name
    @date = params[:date] ? Date.parse(params[:date]) : Date.current
    @view = params[:view] ||= 'day'
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    @employees = [1]

    # TODO: needs to be cleaned up obviously
    @appointments_by_date = Hash.new
    # TODO: ops! not multi-tenent!
    r = Appointment.where(time: @date.beginning_of_month..@date.end_of_month).order(:time).includes(:client)
    r.each do |appointment| #.order(:time).group_by(&:time)
      k = appointment.time.strftime("%Y-%m-%d")
      if @appointments_by_date.has_key?(k)
        @appointments_by_date[k].push(appointment)
      else
        @appointments_by_date[k] = [appointment]
      end
    end

    @appointments_by_hour = Hash.new
    # TODO: ops! not multi-tenent!
    r = Appointment.where(time: @date.beginning_of_day..@date.end_of_day).order(:time).includes(:client)
    r.each do |appointment| #.order(:time).group_by(&:time)
      k = appointment.time.hour
      if @appointments_by_hour.has_key?(k)
        @appointments_by_hour[k].push(appointment)
      else
        @appointments_by_hour[k] = [appointment]
      end
    end
  end

  def create
    begin
      #puts params.require(:appointment).permit(:email).to_yaml
      #puts client_params.merge(account_id: @current_user.account_id).to_yaml

      @client = Client.find_by(params.require(:appointment).permit(:email))
      #puts @client.to_yaml
      @client = Client.create(client_params.merge(account_id: @current_user.account_id)) if @client.nil?
      # TODO: create was not returning id in postgres in prod.  need to reload.
      # is this normal?
      @client = Client.find_by(params.require(:appointment).permit(:email))

      #@client = Client.find_or_create_by(params.require(:appointment).permit(:email)) do |client|
        #client.account_id = @current_user.account_id
        #client.first_name = params.require(:appointment).permit(:first_name)
        #client.first_name = params[:first_name]
      #end

      puts 'Oi1'
      @name = @client.name
      puts 'Oi2'
      @hour = appointment_params[:hour]
      puts 'Oi3'
      time = appointment_params[:time].to_time.change(hour: @hour)
      puts 'Oi4'
      puts appointment_params.merge(account_id: @current_user.account_id,
                               user_id: @current_user.id,
                               client_id: @client.id,
                               time: time).to_yaml

      puts 'Oi5'
      @appointment = Appointment.new(appointment_params.merge(account_id: @current_user.account_id,
                                                              user_id: @current_user.id,
                                                              client_id: @client.id,
                                                              time: time))
      puts 'Oi6'
      @appointment.save
    rescue
      puts 'appointments#create exception'
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
      params.require(:appointment).permit(:time, :hour, :duration)
    end
end
