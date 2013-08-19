class AppointmentsController < ApplicationController
  before_action :authorize_user
  respond_to :json, :html

  # TODO the definition of START_DAY is duplicated
  START_DAY = :sunday
  NAV_TITLE = {day: '%A, %B %e %Y', week: 'week %V - %Y', weeks2: 'week2 %Y', month: '%B %Y', months2: 'Months 2 %B %Y', year: '%Y', years2: '%Y - %Y 2'}

  def index
    @title = @current_user.name
    @date = params[:date] ? Date.parse(params[:date]) : Date.current
    @view = params[:view] ||= 'day'
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    @employees = [1]
#    @appointment = Appointment.new
    @client = Client.new

    # TODO: needs to be cleaned up obviously
    @appointments_by_date = Hash.new
    # TODO: ops! not multi-tenent!
    # TODO: Is account_id get correct id?
    r = Appointment.where(time: @date.beginning_of_month..@date.end_of_month, account_id: @current_user).order(:time).includes(:client)
    r.each do |appointment| #.order(:time).group_by(&:time)
      k = appointment.time.strftime("%Y-%m-%d")
      if @appointments_by_date.has_key?(k)
        @appointments_by_date[k].push(appointment)
      else
        @appointments_by_date[k] = [appointment]
      end
    end

    @appointments_by_week = Hash.new
    # TODO: ops! not multi-tenent!
    # TODO: Is account_id get correct id?
    r = Appointment.where(time: @date.beginning_of_week(START_DAY)..@date.end_of_week(START_DAY), account_id: @current_user).order(:time).includes(:client)
    r.each do |appointment| #.order(:time).group_by(&:time)
      k = appointment.time.strftime("%Y-%m-%d %H")
      pp k
      if @appointments_by_week.has_key?(k)
        @appointments_by_week[k].push(appointment)
      else
        @appointments_by_week[k] = [appointment]
      end
    end

    @appointments_by_hour = Hash.new
    # TODO: ops! not multi-tenent!
    # TODO: Is account_id get correct id?
    r = Appointment.where(time: @date.beginning_of_day..@date.end_of_day, account_id: @current_user).order(:time).includes(:client)
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

      # TODO: this function is a complete mess
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

      unless @client.nil?
        @name = @client.name
        @hour = params.require(:appointment).permit(:hour)[:hour]
        #puts appointment_params[:time]
        # TODO: removing in_time_zone did generate a F with specs. huh?
        time = appointment_params[:time].to_date.in_time_zone.change(hour: @hour)
        #puts time
        #puts appointment_params.merge(account_id: @current_user.account_id,
        #                         user_id: @current_user.id,
        #                         client_id: @client.id,
        #                         time: time).to_yaml

        @appointment = Appointment.new(appointment_params.merge(account_id: @current_user.account_id,
                                                                user_id: @current_user.id,
                                                                client_id: @client.id,
                                                                time: time))
        #@appointment = nil
        #raise 'lazy!'
        @appointment.save
      end
    rescue => e
      puts 'appointments#create exception'
      puts e.message
      if @client.nil?
        puts 'Client was nil!'
        @client = Client.new(client_params.merge(account_id: @current_user.account_id))
        @client.valid?
      else
        puts 'Client was not nil!'
        @client.valid?
      end
      #@appointment = Appointment.new
      #@client = Client.new
    end
  end

  def move
    pp 'Appointments#move!!!!!!'
    @appointment = Appointment.find_by(id: params[:appointment_id])
    @appointment.update(time: params[:date].to_date.in_time_zone.change(hour: params[:hour]))
    pp @appointment
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
