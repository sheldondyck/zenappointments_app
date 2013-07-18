# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  account_id            :integer          not null
#  first_name            :string(255)      not null
#  last_name             :string(255)      not null
#  email                 :string(255)      not null
#  password              :string(255)      not null
#  password_digest       :string(255)      not null
#  account_administrator :boolean          not null
#  active                :boolean          not null
#  created_at            :datetime
#  updated_at            :datetime
#

require 'spec_helper'

describe User do
  before { @account = Account.new( company_name: 'Company Name',
                             active: 1)

    @user = User.new(first_name: 'First Name',
                     last_name: 'Last Name',
                     email: 'acount_1@company.com',
                     password: 'abcdef',
                     password_digest: 'abc',
                     account_administrator: 1,
                     active: 1) }

  subject { @user }

  it { should be_valid }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:account_administrator) }
  it { should respond_to(:active) }

  describe 'first_name' do
    describe 'is valid' do
      before { @user.first_name = 'A' }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @user.first_name = '' }
      it { should_not be_valid }
    end

    describe 'has no valid characters' do
      before { @user.first_name = '     ' }
      it { should_not be_valid }
    end

    describe 'is too long' do
      before { @user.first_name = 'a' * 49 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @user.first_name = 'a' * 51 }
      it { should_not be_valid }
    end
  end

  describe 'last_name' do
    describe 'is valid' do
      before { @user.last_name = 'A' }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @user.last_name = '' }
      it { should_not be_valid }
    end

    describe 'has no valid characters' do
      before { @user.last_name = " \t  " }
      it { should_not be_valid }
    end

    describe 'even if is very long' do
      before { @user.last_name = 'a' * 49 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @user.last_name = 'a' * 51 }
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

  describe 'email' do
    describe 'is empty' do
      before { @user.email = '' }
      it { should_not be_valid }
    end

    describe 'even if is very long' do
      before { @user.email = 'a' * 80 + '@example.com' }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @user.email = 'a' * 101 + '@example.com' }
      it { should_not be_valid }
    end

    describe 'valid format' do
      it 'should be valid' do
        valid_addresses = %w[user@example.com s@a.br user.name@foo.com.br user-name@foo.com user_name@foo.bar.com.br moo-foo@boo.com user+name@foo.br]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          @user.should be_valid
        end
      end
    end

    describe 'invalid format' do
      it 'should be invalid' do
        invalid_addresses = %w[user@example,com @a.br user%name@foo.com.br user_name@foo user@]
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.should_not be_valid
        end
      end
    end

    describe 'is normalized to lower case' do
      subject { @user.email }
      before do
        @account.save
        @user.email = @user.email.upcase
        @user.account_id = @account.id
        @user.save
        @user.email = @user.email.downcase
        @normalized_account = User.find_by email: @user.email
      end
      it { should == @normalized_account.email }
    end

    describe 'duplicated is not valid' do
      before do
        @account.save
        user_with_same_email = @user.dup
        user_with_same_email.account_id = @account.id
        user_with_same_email.save
      end
      it { should_not be_valid }
    end

    describe 'duplicated with different case is not valid' do
      before do
        @account.save
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.account_id = @account.id
        user_with_same_email.save
      end
      it { should_not be_valid }
    end
  end

  describe 'password' do
    describe 'is empty' do
      before { @user.password = '' }
      it { should_not be_valid }
    end

    describe 'even if is very long' do
      before { @user.password = 'a' * 80 }
      it { should be_valid }
    end

    describe 'too short' do
      before { @user.password = 'abcde' }
      it { should_not be_valid }
    end

    describe 'is too long' do
      before { @user.password = 'a' * 101 }
      it { should_not be_valid }
    end
  end
end
