class AppointmentsController < ApplicationController
  prepend_before_action :authorize_user
  respond_to :json, :html

  # TODO the definition of START_DAY is duplicated
  START_DAY = :sunday
  NAV_TITLE = {day: '%A, %B %e %Y', week: 'week %V - %Y', weeks2: 'week2 %Y', month: '%B %Y', months2: 'Months 2 %B %Y', year: '%Y', years2: '%Y - %Y 2'}

  def new
    #@appointment = Appointment.new
    @client = Client.new
    @title = @current_user.name
  end

  def index
    #@appointment = Appointment.new
    @client = Client.new
    @title = @current_user.name
    # TODO is Date.current in current time zone? If not add.
    @date = params[:date] ? Date.parse(params[:date]) : Date.current
    @view = params[:view] ||= 'day'
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    @employees = [1]

    # TODO: this function is a complete mess
    # TODO: needs to be cleaned up obviously
    # TODO: calling 3 selects when only one is used
    @appointments_by_date = Hash.new
    #puts "Account.current_id: #{Account.current_id}"
    r = Appointment.where(time: @date.in_time_zone.beginning_of_month..@date.in_time_zone.end_of_month).order(:time).includes(:client)
    r.each do |appointment| #.order(:time).group_by(&:time)
      k = appointment.time.strftime("%Y-%m-%d")
      if @appointments_by_date.has_key?(k)
        @appointments_by_date[k].push(appointment)
      else
        @appointments_by_date[k] = [appointment]
      end
    end

    @appointments_by_week = Hash.new
    r = Appointment.where(time: @date.in_time_zone.beginning_of_week(START_DAY)..@date.in_time_zone.end_of_week(START_DAY)).order(:time).includes(:client)
    r.each do |appointment| #.order(:time).group_by(&:time)
      k = appointment.time.strftime("%Y-%m-%d %H")
      if @appointments_by_week.has_key?(k)
        @appointments_by_week[k].push(appointment)
      else
        @appointments_by_week[k] = [appointment]
      end
    end

    @appointments_by_hour = Hash.new
    r = Appointment.where(time: @date.in_time_zone.beginning_of_day..@date.in_time_zone.end_of_day).order(:time).includes(:client)
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
      # TODO: this function is a complete mess
      # TODO: this function is a complete mess
      # TODO: this function is a complete mess
      # TODO: this function is a complete mess
      unless params[:client_id].nil?
        @client = Client.find(params[:client_id])
      else
        # TODO: added email: to this and it broke. why?
        puts 'email: ' + params.require(:appointment).permit(:email).to_yaml
        @client = Client.find_by(params.require(:appointment).permit(:email))
      end
      #puts @client.to_yaml
      if @client.nil?
        puts '@client.nil? true'
        @client = Client.create(client_params.merge(account_id: @current_user.account_id))
        puts '@client: ' + @client.to_yaml
        # TODO: create was not returning id in postgres in prod.  need to reload.
        # is this normal?
        # TODO: added email: to this and it broke. why?
        @client = Client.find_by!(params.require(:appointment).permit(:email))
      end

      #@client = Client.find_or_create_by(params.require(:appointment).permit(:email)) do |client|
        #client.account_id = @current_user.account_id
        #client.first_name = params.require(:appointment).permit(:first_name)
        #client.first_name = params[:first_name]
      #end

      unless @client.nil?
        @name = @client.name
        @hour = params.require(:appointment).permit(:hour)[:hour].to_i
        #puts appointment_params[:time]
        # TODO: removing in_time_zone did generate a F with specs. huh?
        time = appointment_params[:time].to_date.in_time_zone.change(hour: @hour)
        puts 'time: ' + time.to_yaml
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
        @appointment.save!
      end
    rescue => e
      puts 'appointments#create exception: ' + e.message
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
    begin
      #puts 'Appointments#move'
      #puts 'move id: ' + params[:appointment_id].to_s
      #puts 'move: ' + params.to_yaml
      @appointment = Appointment.find_by(id: params[:appointment_id])
      @appointment.update(time: params[:date].to_date.in_time_zone.change(hour: params[:hour]))
      #pp @appointment
    rescue => e
      puts 'Appointments#move exception: ' + e.message
    end
  end

  def update
    begin
      #puts 'Appointments#update'
      #puts 'update id: ' + params[:appointment_id].to_s
      #puts 'update: ' + params.to_yaml
      @appointment = Appointment.find_by(id: params[:appointment_id])
      @appointment.update(duration: params[:duration])
      #pp @appointment
    rescue => e
      puts 'Appointments#update exception: ' + e.message
    end
  end

  def delete
    @appointment = Appointment.find_by(id: params[:appointment_id])
  end

  private
    def client_params
      params.require(:appointment).permit(:first_name,
                                           :last_name,
                                           :telephone_cellular,
                                           :email)
    end

    def appointment_params
      params.require(:appointment).permit(:time, :duration)
    end
end
