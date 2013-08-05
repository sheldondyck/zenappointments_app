# == Schema Information
#
# Table name: clients
#
#  id                 :integer          not null, primary key
#  account_id         :integer          not null
#  first_name         :string(255)      not null
#  last_name          :string(255)
#  birthday           :date
#  email              :string(255)
#  telephone_cellular :string(255)
#  telephone_home     :string(255)
#  telephone_office   :string(255)
#  custom_fields      :hstore
#  created_at         :datetime
#  updated_at         :datetime
#

class Client < ActiveRecord::Base
  belongs_to :account

  before_save { |client| client.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-_.]+@[a-z\d\-_.]+\.[a-z]+\z/i
  validates :first_name,  presence: true,
                          length: { maximum: 50 }
  validates :last_name,   length: { maximum: 50 }
  validates :email,       length: { minimum: 4, maximum: 100 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }

  def name
    first_name + ' ' + last_name
  end
end
