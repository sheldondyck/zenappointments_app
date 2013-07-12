# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  account_id            :integer
#  first_name            :string(255)
#  last_name             :string(255)
#  email                 :string(255)
#  password              :string(255)
#  password_digest       :string(255)
#  account_administrator :boolean
#  active                :boolean
#  created_at            :datetime
#  updated_at            :datetime
#

require 'spec_helper'

describe User do
  before { @account = Account.new(owner_first_name: 'Owner First Name',
                             owner_last_name: 'Owner Last Name',
                             company_name: 'Company Name',
                             email: 'acount_1@company.com',
                             active: 1)

    @user = User.new(account_id: @account.id,
                     first_name: 'First Name',
                     last_name: 'Last Name',
                     email: 'acount_1@company.com',
                     account_administrator: 1,
                     active: 1) }

  subject { @user }

  it { should be_valid }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:account_administrator) }
  it { should respond_to(:active) }

  describe 'first_name' do
    describe 'is valid' do
      before { @user.first_name = "A" }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @user.first_name = "" }
      it { should_not be_valid }
    end

    describe 'has no valid characters' do
      before { @user.first_name = "     " }
      it { should_not be_valid }
    end

    describe 'is too long' do
      before { @user.first_name = "a" * 49 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @user.first_name = "a" * 51 }
      it { should_not be_valid }
    end
  end

  describe 'last_name' do
    describe 'is valid' do
      before { @user.last_name = "A" }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @user.last_name = "" }
      it { should_not be_valid }
    end

    describe 'has no valid characters' do
      before { @user.last_name = " \t  " }
      it { should_not be_valid }
    end

    describe 'is very long' do
      before { @user.last_name = "a" * 49 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @user.last_name = "a" * 51 }
      it { should_not be_valid }
    end
  end

  describe 'name' do
    subject { @user.name }

    describe 'is correct' do
      it { should == 'First Name Last Name' }
    end

    describe 'is incorrect' do
      it { should_not == 'Name Last Name' }
    end
  end

end
