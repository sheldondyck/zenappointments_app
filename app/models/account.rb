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
  before_save { |account| account.email = email.downcase }

  has_many :users, dependent: :delete_all
  has_many :employees, dependent: :delete_all
  has_many :clients, dependent: :delete_all
  has_many :appointments, dependent: :delete_all

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :owner_first_name,  presence: true,
                                length: { maximum: 50 }
  validates :owner_last_name,   presence: true,
                                length: { maximum: 50 }
  validates :company_name,      presence: true,
                                length: { maximum: 100 },
                                uniqueness: { case_sensitive: false }
  validates :email,             presence: true,
                                length: { maximum: 100 },
                                format: { with: VALID_EMAIL_REGEX },
                                uniqueness: { case_sensitive: false }

  def owner_name
    owner_first_name + ' ' + owner_last_name
  end
end
