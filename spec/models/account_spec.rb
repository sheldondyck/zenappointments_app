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
  pending "add some examples to (or delete) #{__FILE__}"
end
