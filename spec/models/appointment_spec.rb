# == Schema Information
#
# Table name: appointments
#
#  id          :integer          not null, primary key
#  account_id  :integer          not null
#  user_id     :integer          not null
#  employee_id :integer
#  client_id   :integer          not null
#  time        :datetime         not null
#  duration    :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Appointment do
  before do
    @appointment = build(:appointment)
  end

  subject { @appointment }

  it { should be_valid }
  it { should respond_to(:time) }
  it { should respond_to(:duration) }

  describe 'time' do
    describe 'is valid' do
      before { @appointment.time = "2001-01-01 00:00:00" }
      it { should be_valid }
    end

    describe 'when time is nil' do
      before { @appointment.time = nil }
      it { should_not be_valid }
    end
  end

  describe 'duration' do
    describe 'one hour' do
      before { @appointment.duration = 60 }
      it { should be_valid }
    end

    describe '15 minutes' do
      before { @appointment.duration = 15 }
      it { should be_valid }
    end

    describe '24 hours' do
      before { @appointment.duration = 60*24 }
      it { should be_valid }
    end

    describe 'is invalid' do
      before { @appointment.duration = nil }
      it { should_not be_valid }
    end

    describe '0 minutes' do
      before { @appointment.duration = 0 }
      it { should_not be_valid }
    end

    describe '14 minutes' do
      before { @appointment.duration = 14 }
      it { should_not be_valid }
    end

    describe 'too long' do
      before { @appointment.duration = 60*24 + 1 }
      it { should_not be_valid }
    end
  end
end
