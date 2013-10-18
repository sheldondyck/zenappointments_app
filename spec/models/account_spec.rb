# == Schema Information
#
# Table name: accounts
#
#  id            :integer          not null, primary key
#  company_name  :string(255)      not null
#  configuration :hstore
#  active        :boolean          not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Account do
  before do
    @account = build(:account)
  end

  subject { @account }

  it { should be_valid }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:company_name) }
  it { should respond_to(:configuration) }
  it { should respond_to(:active) }
  it { should respond_to(:users) }
  it { should respond_to(:clients) }
  it { should respond_to(:employees) }
  it { should respond_to(:appointments) }
  it { expect(Account).to respond_to(:current_id) }
  it { expect(Account).to respond_to(:slots_per_hour) }
  it { expect(Account).to respond_to(:minutes_per_slot) }
  it { expect(Account).to respond_to(:starting_hour) }
  it { expect(Account).to respond_to(:ending_hour) }
  it { expect(Account).to respond_to(:appointment_duration) }

  describe 'company_name' do
    describe 'is valid' do
      before { @account.company_name = "A" }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @account.company_name = "" }
      it { should_not be_valid }
    end

    describe 'has no valid characters' do
      before { @account.company_name = "  \n   " }
      it { should_not be_valid }
    end

    describe 'is very long' do
      before { @account.company_name = "a" * 99 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @account.company_name = "a" * 101 }
      it { should_not be_valid }
    end

    describe 'duplicated is not valid' do
      before do
        @account.save
        @account_with_same_company_name = @account.dup
        @account_with_same_company_name.save
      end
      it { expect(@account_with_same_company_name).not_to be_valid }
    end

    describe 'duplicated with different case is not valid' do
      before do
        @account.save
        @account_with_same_company_name = @account.dup
        @account_with_same_company_name.company_name = @account.company_name.upcase
        @account_with_same_company_name.save
      end
      it { expect(@account_with_same_company_name).not_to be_valid }
    end
  end

  describe 'active' do
    describe 'is valid' do
      before { @account.active = 1 }
      it { should be_valid }
    end

    describe 'is valid' do
      before { @account.active = 0 }
      it { should be_valid }
    end

    describe 'is valid' do
      before { @account.active = 2 }
      it { should be_valid }
    end

    describe 'is required' do
      before { @account.active = nil }
      it { should_not be_valid }
    end
  end

  describe 'user associated with account' do
    before { @user = create(:user) }

    describe 'has correct first_name' do
      it { @account.user.first_name.should == 'First Name' }
    end

    describe 'has correct last_name' do
      it { @account.user.last_name.should == 'Last Name' }
    end

    describe 'is correct' do
      it { @account.user.name.should == 'First Name Last Name' }
    end

    describe 'is incorrect' do
      it { @account.user.name.should_not == 'Name Last Name' }
    end

    describe 'has correct email' do
      it { @account.user.email.should == 'account@company.com' }
    end

    describe 'has admin privs' do
      it { @account.user.account_administrator.should be_true }
    end
  end
end
