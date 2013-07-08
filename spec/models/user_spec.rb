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
  pending "add some examples to (or delete) #{__FILE__}"
end
