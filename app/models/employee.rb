# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  account_id :integer
#  first_name :string(255)
#  last_name  :string(255)
#  active     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Employee < ActiveRecord::Base
  belongs_to :account
end
