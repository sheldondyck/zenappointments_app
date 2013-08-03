require 'spec_helper'

describe AppointmentsController do
  it { should respond_to(:index) }
  it { should respond_to(:change) }
  it { should respond_to(:create) }
end
