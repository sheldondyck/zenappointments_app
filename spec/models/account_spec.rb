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
                             active: 1) }
  subject { @account }

  it { should be_valid }
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

end
