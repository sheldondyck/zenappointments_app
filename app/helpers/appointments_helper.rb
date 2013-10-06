module AppointmentsHelper
  def format_appointment_interval(hour, slot, duration)
    # TODO magic number 60
    # TODO magic number 15mins
    #"#{hour}:#{slot * 15} - #{hour + duration / 60}:#{slot * 15}"
    "%d:%02d - %d:%02d" % [hour, slot * 15, hour + duration / 60, slot * 15]
  end
end
