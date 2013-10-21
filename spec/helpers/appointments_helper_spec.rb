require 'spec_helper'

describe AppointmentsHelper do
  subject { helper }

  describe 'active_btn' do
    it { should respond_to(:active_btn) }
    it { expect(active_btn('day', 'day')).to eq('btn btn-default active') }
    it { expect(active_btn('day', 'week')).to eq('btn btn-default') }
  end

  describe 'format_appointment_interval' do
    it { should respond_to(:format_appointment_interval) }
    it { expect(format_appointment_interval(0, 0, 15)).to eq('00:00 - 00:15') }
    it { expect(format_appointment_interval(0, 1, 15)).to eq('00:15 - 00:30') }
    it { expect(format_appointment_interval(0, 2, 15)).to eq('00:30 - 00:45') }
    it { expect(format_appointment_interval(0, 3, 15)).to eq('00:45 - 01:00') }
    it { expect(format_appointment_interval(12, 0, 15)).to eq('12:00 - 12:15') }
    it { expect(format_appointment_interval(12, 1, 15)).to eq('12:15 - 12:30') }
    it { expect(format_appointment_interval(12, 2, 15)).to eq('12:30 - 12:45') }
    it { expect(format_appointment_interval(12, 3, 15)).to eq('12:45 - 13:00') }
    it { expect(format_appointment_interval(22, 0, 15)).to eq('22:00 - 22:15') }
    it { expect(format_appointment_interval(22, 1, 15)).to eq('22:15 - 22:30') }
    it { expect(format_appointment_interval(22, 2, 15)).to eq('22:30 - 22:45') }
    it { expect(format_appointment_interval(22, 3, 15)).to eq('22:45 - 23:00') }
    it { expect(format_appointment_interval(23, 0, 15)).to eq('23:00 - 23:15') }
    it { expect(format_appointment_interval(23, 1, 15)).to eq('23:15 - 23:30') }
    it { expect(format_appointment_interval(23, 2, 15)).to eq('23:30 - 23:45') }
    it { expect(format_appointment_interval(23, 3, 15)).to eq('23:45 - 00:00') }

    it { expect(format_appointment_interval(0, 0, 30)).to eq('00:00 - 00:30') }
    it { expect(format_appointment_interval(0, 1, 30)).to eq('00:15 - 00:45') }
    it { expect(format_appointment_interval(0, 2, 30)).to eq('00:30 - 01:00') }
    it { expect(format_appointment_interval(0, 3, 30)).to eq('00:45 - 01:15') }
    it { expect(format_appointment_interval(12, 0, 30)).to eq('12:00 - 12:30') }
    it { expect(format_appointment_interval(12, 1, 30)).to eq('12:15 - 12:45') }
    it { expect(format_appointment_interval(12, 2, 30)).to eq('12:30 - 13:00') }
    it { expect(format_appointment_interval(12, 3, 30)).to eq('12:45 - 13:15') }
    it { expect(format_appointment_interval(22, 0, 30)).to eq('22:00 - 22:30') }
    it { expect(format_appointment_interval(22, 1, 30)).to eq('22:15 - 22:45') }
    it { expect(format_appointment_interval(22, 2, 30)).to eq('22:30 - 23:00') }
    it { expect(format_appointment_interval(22, 3, 30)).to eq('22:45 - 23:15') }
    it { expect(format_appointment_interval(23, 0, 30)).to eq('23:00 - 23:30') }
    it { expect(format_appointment_interval(23, 1, 30)).to eq('23:15 - 23:45') }
    it { expect(format_appointment_interval(23, 2, 30)).to eq('23:30 - 00:00') }
    it { expect(format_appointment_interval(23, 3, 30)).to eq("23:45 - 00:15") }

    it { expect(format_appointment_interval(0, 0, 45)).to eq('00:00 - 00:45') }
    it { expect(format_appointment_interval(0, 1, 45)).to eq('00:15 - 01:00') }
    it { expect(format_appointment_interval(0, 2, 45)).to eq('00:30 - 01:15') }
    it { expect(format_appointment_interval(0, 3, 45)).to eq('00:45 - 01:30') }
    it { expect(format_appointment_interval(12, 0, 45)).to eq('12:00 - 12:45') }
    it { expect(format_appointment_interval(12, 1, 45)).to eq('12:15 - 13:00') }
    it { expect(format_appointment_interval(12, 2, 45)).to eq('12:30 - 13:15') }
    it { expect(format_appointment_interval(12, 3, 45)).to eq('12:45 - 13:30') }
    it { expect(format_appointment_interval(22, 0, 45)).to eq('22:00 - 22:45') }
    it { expect(format_appointment_interval(22, 1, 45)).to eq('22:15 - 23:00') }
    it { expect(format_appointment_interval(22, 2, 45)).to eq('22:30 - 23:15') }
    it { expect(format_appointment_interval(22, 3, 45)).to eq('22:45 - 23:30') }
    it { expect(format_appointment_interval(23, 0, 45)).to eq('23:00 - 23:45') }
    it { expect(format_appointment_interval(23, 1, 45)).to eq('23:15 - 00:00') }
    it { expect(format_appointment_interval(23, 2, 45)).to eq('23:30 - 00:15') }
    it { expect(format_appointment_interval(23, 3, 45)).to eq('23:45 - 00:30') }

    it { expect(format_appointment_interval(0, 0, 60)).to eq('00:00 - 01:00') }
    it { expect(format_appointment_interval(0, 1, 60)).to eq('00:15 - 01:15') }
    it { expect(format_appointment_interval(0, 2, 60)).to eq('00:30 - 01:30') }
    it { expect(format_appointment_interval(0, 3, 60)).to eq('00:45 - 01:45') }
    it { expect(format_appointment_interval(12, 0, 60)).to eq('12:00 - 13:00') }
    it { expect(format_appointment_interval(12, 1, 60)).to eq('12:15 - 13:15') }
    it { expect(format_appointment_interval(12, 2, 60)).to eq('12:30 - 13:30') }
    it { expect(format_appointment_interval(12, 3, 60)).to eq('12:45 - 13:45') }
    it { expect(format_appointment_interval(22, 0, 60)).to eq('22:00 - 23:00') }
    it { expect(format_appointment_interval(22, 1, 60)).to eq('22:15 - 23:15') }
    it { expect(format_appointment_interval(22, 2, 60)).to eq('22:30 - 23:30') }
    it { expect(format_appointment_interval(22, 3, 60)).to eq('22:45 - 23:45') }
    it { expect(format_appointment_interval(23, 0, 60)).to eq('23:00 - 00:00') }
    it { expect(format_appointment_interval(23, 1, 60)).to eq('23:15 - 00:15') }
    it { expect(format_appointment_interval(23, 2, 60)).to eq('23:30 - 00:30') }
    it { expect(format_appointment_interval(23, 3, 60)).to eq('23:45 - 00:45') }
  end
end
