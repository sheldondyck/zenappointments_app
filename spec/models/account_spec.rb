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
                             active: 1)}
  subject { @account }

  it { should respond_to(:owner_first_name) }
  it { should respond_to(:owner_last_name) }
  it { should respond_to(:owner_name) }
  it { should respond_to(:email) }
  it { should respond_to(:configuration) }
  it { should respond_to(:active) }
end
