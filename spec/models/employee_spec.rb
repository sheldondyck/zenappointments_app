# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  account_id :integer          not null
#  first_name :string(255)      not null
#  last_name  :string(255)      not null
#  active     :boolean          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Employee do
end
