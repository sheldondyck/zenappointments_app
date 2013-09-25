require 'spec_helper'

describe AppointmentsHelper do
  subject { helper }

  it { should respond_to(:format_appointment_interval) }
end
