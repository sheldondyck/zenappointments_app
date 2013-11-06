require 'spec_helper'

describe AccountsHelper do
  subject { helper }

  describe 'zen_account_demo_message' do
    it { should respond_to(:zen_account_demo_message) }
    #it { expect(format_appointment_interval(12, 2, 45)).to eq('12:30 - 13:15') }
  end
end
