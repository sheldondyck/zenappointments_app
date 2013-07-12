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

class User < ActiveRecord::Base
  belongs_to :account

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name,  presence: true,
                          length: { maximum: 50 }
  validates :last_name,   presence: true,
                          length: { maximum: 50 }
  validates :email,       presence: true,
                          length: { maximum: 100 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }

  def name
    first_name + ' ' + last_name
  end
end
