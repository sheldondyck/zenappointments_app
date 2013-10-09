module AppointmentsHelper
  def format_appointment_interval(hour, slot, duration)
    # TODO magic number 15mins
    start = Time.new(1900, 1, 1, hour, slot * 15, 0)
    finish = start + duration.minutes
    "#{start.strftime("%H:%M")} - #{finish.strftime("%H:%M")}"
  end
end
