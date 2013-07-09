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
  before { @user = User.new(first_name: 'Owner First Name',
                             last_name: 'Owner Last Name',
                             email: 'acount_1@company.com',
                             account_administrator: 1,
                             active: 1)}
  subject { @user }

  it { should be_valid }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:account_administrator) }
  it { should respond_to(:active) }

end
