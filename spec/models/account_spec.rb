# == Schema Information
#
# Table name: accounts
#
#  id               :integer          not null, primary key
#  owner_first_name :string(255)
#  owner_last_name  :string(255)
#  company_name     :string(255)
#  email            :string(255)
#  configuration    :hstore
#  active           :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Account do
  before { @account = Account.new(owner_first_name: 'Owner First Name',
                             owner_last_name: 'Owner Last Name',
                             company_name: 'Company Name',
                             email: 'acount_1@company.com',
                             active: 1) }
  subject { @account }

  it { should be_valid }
  it { should respond_to(:owner_first_name) }
  it { should respond_to(:owner_last_name) }
  it { should respond_to(:owner_name) }
  it { should respond_to(:email) }
  it { should respond_to(:configuration) }
  it { should respond_to(:active) }

  describe 'owner_first_name' do
    describe 'is valid' do
      before { @account.owner_first_name = "A" }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @account.owner_first_name = "" }
      it { should_not be_valid }
    end

    describe 'has no valid characters' do
      before { @account.owner_first_name = "     " }
      it { should_not be_valid }
    end

    describe 'is too long' do
      before { @account.owner_first_name = "a" * 49 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @account.owner_first_name = "a" * 51 }
      it { should_not be_valid }
    end
  end

  describe 'owner_last_name' do
    describe 'is valid' do
      before { @account.owner_last_name = "A" }
      it { should be_valid }
    end

    describe 'is empty' do
      before { @account.owner_last_name = "" }
      it { should_not be_valid }
    end

    describe 'has no valid characters' do
      before { @account.owner_last_name = " \t  " }
      it { should_not be_valid }
    end

    describe 'is very long' do
      before { @account.owner_last_name = "a" * 49 }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @account.owner_last_name = "a" * 51 }
      it { should_not be_valid }
    end
  end

  describe 'owner_name' do
    subject { @account.owner_name }

    describe 'is correct' do
      it { should == 'Owner First Name Owner Last Name' }
    end

    describe 'is incorrect' do
      it { should_not == 'Owner Name Owner Last Name' }
    end
  end

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
        account_with_same_company_name.email = 'account_2@company.com'
        account_with_same_company_name.save
      end
      it { should_not be_valid }
    end

    describe 'duplicated with different case is not valid' do
      before do
        account_with_same_company_name = @account.dup
        account_with_same_company_name.email = 'account_2@company.com'
        account_with_same_company_name.company_name = @account.company_name.upcase
        account_with_same_company_name.save
      end
      it { should_not be_valid }
    end
  end

  describe 'email' do
    describe 'is empty' do
      before { @account.email = "" }
      it { should_not be_valid }
    end

    describe 'is very long' do
      before { @account.email = "a" * 80 + "@example.com" }
      it { should be_valid }
    end

    describe 'is too long' do
      before { @account.email = "a" * 101 + "@example.com" }
      it { should_not be_valid }
    end

    describe 'valid format' do
      it 'should be valid' do
        valid_addresses = %w[user@example.com s@a.br user.name@foo.com.br user-name@foo.com user_name@foo.bar.com.br moo-foo@boo.com user+name@foo.br]
        valid_addresses.each do |valid_address|
          @account.email = valid_address
          @account.should be_valid
        end
      end
    end

    describe 'invalid format' do
      it 'should be invalid' do
        invalid_addresses = %w[user@example,com @a.br user%name@foo.com.br user_name@foo user@]
        invalid_addresses.each do |invalid_address|
          @account.email = invalid_address
          @account.should_not be_valid
        end
      end
    end

    describe 'is normalized to lower case' do
      subject { @account.email }
      before do
        @account.email = @account.email.upcase
        @account.save
        @account.email = @account.email.downcase
        @normalized_account = Account.find_by email: @account.email
      end
      it { should == @normalized_account.email }
    end

    describe 'duplicated is not valid' do
      before do
        account_with_same_email = @account.dup
        account_with_same_email.company_name = 'Company Name 2'
        account_with_same_email.save
      end
      it { should_not be_valid }
    end

    describe 'duplicated with different case is not valid' do
      before do
        account_with_same_email = @account.dup
        account_with_same_email.company_name = 'Company Name 2'
        account_with_same_email.email = @account.email.upcase
        account_with_same_email.save
      end
      it { should_not be_valid }
    end
  end
end
