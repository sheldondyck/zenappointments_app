module AppointmentsHelper
  def format_appointment_interval(hour, slot, duration)
    start = Time.new(1900, 1, 1, hour, slot * Account.minutes_per_slot, 0)
    finish = start + duration.minutes
    "#{start.strftime("%H:%M")} - #{finish.strftime("%H:%M")}"
  end

  def active_btn(view_name, view_active)
    if view_name == view_active
      return 'btn btn-default active'
    else
      return 'btn btn-default'
    end
  end
end
