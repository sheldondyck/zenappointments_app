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

class User < ActiveRecord::Base
  belongs_to :account
end
