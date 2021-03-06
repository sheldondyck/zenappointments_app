class AppointmentsController < ApplicationController
  prepend_before_action :authorize_user
  respond_to :json, :html

  NAV_TITLE = {day: '%A, %B %e %Y', week: 'Week %V - %Y', weeks2: 'Bi-Weekly %Y', month: '%B %Y', months2: 'Bi-Monthly  %B %Y', year: '%Y', years2: '%Y - %Y'}

  def new
    @client = Client.new
    @title = @current_user.name
  end

  # TODO: day/week/month/year needs to be cleaned up obviously
  def day
    @client = Client.new
    @title = @current_user.name
    @view = 'day'
    # TODO is Date.parse in current time zone? If not add.
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    # TODO: brakeman is warning of security problem with this line
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    # TODO: should employees stay or go?
    @employees = [1]

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

    render 'index'
  end

  def week
    @client = Client.new
    @title = @current_user.name
    @view = 'week'
    # TODO is Date.parse in current time zone? If not add.
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @date = @date.beginning_of_week(Account.start_of_week) if @view == 'week'
    # TODO: brakeman is warning of security problem with this line
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    # TODO: should employees stay or go?
    @employees = [1]

    @appointments_by_week = Hash.new
    r = Appointment.where(time: @date.in_time_zone.beginning_of_week(Account.start_of_week)..@date.in_time_zone.end_of_week(Account.start_of_week)).order(:time).includes(:client)
    r.each do |appointment| #.order(:time).group_by(&:time)
      k = appointment.time.strftime("%Y-%m-%d %H:%M")
      if @appointments_by_week.has_key?(k)
        @appointments_by_week[k].push(appointment)
      else
        @appointments_by_week[k] = [appointment]
      end
    end

    render 'index'
  end

  def month
    @client = Client.new
    @title = @current_user.name
    @view = 'month'
    # TODO is Date.parse in current time zone? If not add.
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    # TODO: brakeman is warning of security problem with this line
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    # TODO: should employees stay or go?
    @employees = [1]

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

    render 'index'
  end

  def year
    @client = Client.new
    @title = @current_user.name
    @view = 'year'
    # TODO is Date.parse in current time zone? If not add.
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    # TODO: brakeman is warning of security problem with this line
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    # TODO: should employees stay or go?
    @employees = [1]

    # TODO add all appoinments for the year?
    @appointments_year = Hash.new
    #puts "Account.current_id: #{Account.current_id}"
    r = Appointment.where(time: @date.in_time_zone.beginning_of_year..@date.in_time_zone.end_of_year).order(:time).includes(:client)
    r.each do |appointment| #.order(:time).group_by(&:time)
      k = appointment.time.strftime("%Y-%m-%d")
      if @appointments_year.has_key?(k)
        @appointments_year[k].push(appointment)
      else
        @appointments_year[k] = [appointment]
      end
    end

    render 'index'
  end

  def index
    #@appointment = Appointment.new
    @client = Client.new
    @title = @current_user.name
    #@view = params[:view] ||= 'day'
    @view = 'day'
    # TODO is Date.parse in current time zone? If not add.
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
#    @date = @date.beginning_of_week(Account.start_of_week) if @view == 'week'
#    # TODO: brakeman is warning of security problem with this line
    @nav_title = @date.strftime(NAV_TITLE[@view.to_sym])
    # TODO: should employees stay or go?
    @employees = [1]

    # TODO: this function is a complete mess
    # TODO: needs to be cleaned up obviously
    # TODO: calling 3 selects when only one is used
#    @appointments_by_date = Hash.new
#    #puts "Account.current_id: #{Account.current_id}"
#    r = Appointment.where(time: @date.in_time_zone.beginning_of_month..@date.in_time_zone.end_of_month).order(:time).includes(:client)
#    r.each do |appointment| #.order(:time).group_by(&:time)
#      k = appointment.time.strftime("%Y-%m-%d")
#      if @appointments_by_date.has_key?(k)
#        @appointments_by_date[k].push(appointment)
#      else
#        @appointments_by_date[k] = [appointment]
#      end
#    end
#
#    @appointments_by_week = Hash.new
#    r = Appointment.where(time: @date.in_time_zone.beginning_of_week(Account.start_of_week)..@date.in_time_zone.end_of_week(Account.start_of_week)).order(:time).includes(:client)
#    r.each do |appointment| #.order(:time).group_by(&:time)
#      k = appointment.time.strftime("%Y-%m-%d %H:%M")
#      if @appointments_by_week.has_key?(k)
#        @appointments_by_week[k].push(appointment)
#      else
#        @appointments_by_week[k] = [appointment]
#      end
#    end
#
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
      # TODO find the RailsWay(tm) of doing this
      if params[:appointment][:client_id].to_i > 0
        puts 'client_id: ' + params[:appointment][:client_id]
        @client = Client.find_by!(id: params[:appointment][:client_id])
      else
        @client = Client.find_or_create_by!(email: params[:appointment][:email]) do |client|
          client.account_id = @current_user.account_id
          client.first_name = params[:appointment][:first_name]
          client.last_name = params[:appointment][:last_name]
          client.telephone_cellular = params[:appointment][:telephone_cellular]
        end
      end

      puts @client.to_yaml

      @name = @client.name
      @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
      @hour = params[:appointment][:hour].to_i
      @slot = params[:appointment][:slot].to_i
      # TODO: removing in_time_zone did generate a F with specs. huh?
      time = permit_appointment_params[:time].to_date.in_time_zone.change(hour: @hour)
      puts 'time: ' + time.to_yaml
      @appointment = Appointment.create!(permit_appointment_params.merge(account_id: @current_user.account_id,
                                                              user_id: @current_user.id,
                                                              client_id: @client.id,
                                                              time: time))
      puts @appointment.to_yaml
    rescue => e
      puts 'appointments#create exception: ' + e.message
      if @client.nil?
        puts 'appointments#create client was nil'
        @client = Client.new(permit_client_params.merge(account_id: @current_user.account_id))
        @client.valid?
      else
        puts 'appointments#create client was not nil'
        @client.valid?
      end
    end
  end

  def move
    begin
      #puts 'Appointments#move'
      #puts 'move id: ' + params[:appointment_id].to_s
      #puts 'move: ' + params.to_yaml
      @hour = params[:hour].to_i
      @slot = params[:slot].to_i
      @appointment = Appointment.find_by!(id: params[:appointment_id])
      # TODO what do we do about slot? remove? add more generic solution?
      # TODO does not use default_scope. why?
      @appointment.update(time: params[:date].to_date.in_time_zone.change(hour: params[:hour], min: params[:slot].to_i * Account.minutes_per_slot))
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
      # TODO update client data as well
      # TODO should move and update be combined into one action?
      # TODO does not use default_scope. why?
      @hour = params[:hour].to_i
      @slot = params[:slot].to_i
      @appointment = Appointment.find_by!(id: params[:appointment_id])
      @appointment.update(duration: params[:duration])
      #pp @appointment
    rescue => e
      puts 'Appointments#update exception: ' + e.message
    end
  end

  def destroy
    @appointment = Appointment.find_by!(id: params[:appointment_id])
    # TODO destroy here does not use default scope. why?
    @appointment.delete
  end

  private
    def permit_client_params
      params.require(:appointment).permit(:first_name,
                                           :last_name,
                                           :telephone_cellular,
                                           :email)
    end

    def permit_appointment_params
      params.require(:appointment).permit(:time, :duration)
    end
end
