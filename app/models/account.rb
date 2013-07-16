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

# TODO: change company_name to organization_name or office_name?
#
class Account < ActiveRecord::Base
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :email
  attr_accessor :password

  has_many :users,        dependent: :delete_all
  has_many :employees,    dependent: :delete_all
  has_many :clients,      dependent: :delete_all
  has_many :appointments, dependent: :delete_all

  validates :company_name, presence: true,
                           length: { maximum: 100 },
                           uniqueness: { case_sensitive: false }
  validates :active,       inclusion: { in: [true, false] }
end
