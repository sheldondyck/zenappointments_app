# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  account_id            :integer          not null
#  first_name            :string(255)      not null
#  last_name             :string(255)      not null
#  email                 :string(255)      not null
#  password_digest       :string(255)      not null
#  signin_token          :string(255)      not null
#  account_administrator :boolean          not null
#  active                :boolean          not null
#  created_at            :datetime
#  updated_at            :datetime
#

require 'spec_helper'

describe User do
  before do
    @user = build(:user)
  end

  subject { @user }

  it { should be_valid }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:signin_token) }
  it { should respond_to(:account_administrator) }
  it { should respond_to(:active) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:account) }
  it { should respond_to(:appointments) }
  it { expect(User).to respond_to(:new_signin_token) }
  it { expect(User).to respond_to(:encrypt) }

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
        valid_addresses = %w[user@example.com s@a.br user.name@foo.com.br user-name@foo.com user_name@foo.bar.com.br moo-foo@boo.com user+name@foo.br my_email@my_company.com]
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
        @user.email = @user.email.upcase
        @user.save
        @user.email = @user.email.downcase
        @normalized_account = User.find_by email: @user.email
      end
      it { should == @normalized_account.email }
    end

    describe 'duplicated is not valid' do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.save
      end
      it { should_not be_valid }
    end

    describe 'duplicated with different case is not valid' do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
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

  describe 'password_digest' do
    before { @user.save }
    its(:password_digest) { should_not be_blank }
  end

  describe 'signin_token' do
    before { @user.save }
    its(:signin_token) { should_not be_blank }
  end

  describe 'authenticate' do
    before { @user.save }
    describe 'with valid password' do
      it { @user.authenticate('abcdef').should eq @user }
    end

    describe 'with invalid password' do
    before { @user.save }
      it { @user.authenticate('1abcdef').should_not eq @user }
    end
  end

  describe 'signin_token' do
    it { expect(User.new_signin_token).not_to be_equal User.new_signin_token }
  end
end
