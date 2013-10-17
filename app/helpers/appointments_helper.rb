module AppointmentsHelper
  def format_appointment_interval(hour, slot, duration)
    start = Time.new(1900, 1, 1, hour, slot * Account.minutes_per_slot, 0)
    finish = start + duration.minutes
    "#{start.strftime("%H:%M")} - #{finish.strftime("%H:%M")}"
  end
end
