# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  account_id            :integer          not null
#  first_name            :string(255)      not null
#  last_name             :string(255)      not null
#  email                 :string(255)      not null
#  password              :string(255)      not null
#  password_digest       :string(255)      not null
#  account_administrator :boolean          not null
#  active                :boolean          not null
#  created_at            :datetime
#  updated_at            :datetime
#

class User < ActiveRecord::Base
  before_save { |user| user.email = email.downcase }

  belongs_to :account

  has_many :appointments

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name,  presence: true,
                          length: { maximum: 50 }
  validates :last_name,   presence: true,
                          length: { maximum: 50 }
  validates :email,       presence: true,
                          length: { maximum: 100 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }
  validates :password,    presence: true,
                          length: { minimum: 6, maximum: 100 }
  validates :active,      inclusion: { in: [true, false] }

  def name
    first_name + ' ' + last_name
  end
end
