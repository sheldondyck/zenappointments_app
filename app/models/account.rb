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

class Account < ActiveRecord::Base
  has_many :users, dependent: :delete_all
  has_many :employees, dependent: :delete_all
  has_many :clients, dependent: :delete_all
  has_many :appointments, dependent: :delete_all

  def owner_name
    owner_first_name + ' ' + owner_last_name
  end
end
