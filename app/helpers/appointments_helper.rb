module AppointmentsHelper
  def format_appointment_interval(hour, duration)
    # TODO magic number 60
    "#{hour}:00 - #{hour + duration / 60}:00"
  end
end
