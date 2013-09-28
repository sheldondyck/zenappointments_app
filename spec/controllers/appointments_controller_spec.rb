require 'spec_helper'

describe AppointmentsController do
  it { should respond_to(:new) }
  it { should respond_to(:index) }
  it { should respond_to(:create) }
  it { should respond_to(:move) }
  it { should respond_to(:update) }
  it { should respond_to(:delete) }
end
