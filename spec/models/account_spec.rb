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
  before { @account = Account.new(company_name: 'Company Name',
                             active: 1)
    @user = User.new(first_name: 'First Name',
                     last_name: 'Last Name',
                     email: 'acount_1@company.com',
                     password: 'abc',
                     password_digest: 'abc',
                     account_administrator: 1,
                     active: 1) }
  subject { @account }

  it { should be_valid }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:company_name) }
  it { should respond_to(:configuration) }
  it { should respond_to(:active) }

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
        account_with_same_company_name = @account.dup
        account_with_same_company_name.save
      end
      it { should_not be_valid }
    end

    describe 'duplicated with different case is not valid' do
      before do
        account_with_same_company_name = @account.dup
        account_with_same_company_name.company_name = @account.company_name.upcase
        account_with_same_company_name.save
      end
      it { should_not be_valid }
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
    before { @account.save
      @user.account_id = @account.id
      @user.save
    }

    describe 'has correct first_name' do
      #puts @account.user.to_yaml
      pending 'first name from user'
    end

    describe 'has correct last_name' do
      pending 'last name from user'
    end

    describe 'has correct email' do
      pending 'email from user'
    end
  end
end
