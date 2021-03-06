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
  has_many :appointments

  before_save { |client| client.email = email.downcase }

  # TODO VALID_EMAIL_REGEX is duplicated in users.rb
  VALID_EMAIL_REGEX = /\A[\w+\-_.]+@[a-z\d\-_.]+\.[a-z]+\z/i
  validates :first_name,  presence: true,
                          length: { maximum: 50 }
  validates :last_name,   length: { maximum: 50 }
  validates :email,       length: { minimum: 4, maximum: 100 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }

  default_scope { where(account_id: Account.current_id) }

  scope :search_name, -> (term, limit) { where("first_name ilike :q or last_name ilike :q",
                                               q: "#{term}%").order('first_name, last_name').limit(limit) }

  def name
    first_name + ' ' + last_name
  end
end
