# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  account_id            :integer          not null
#  first_name            :string(255)      not null
#  last_name             :string(255)      not null
#  email                 :string(255)      not null
#  password_digest       :string(255)      not null
#  signin_token          :string(255)      not null
#  account_administrator :boolean          not null
#  active                :boolean          not null
#  created_at            :datetime
#  updated_at            :datetime
#

require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :password

  before_save { |user| user.email = email.downcase }
  before_create :create_signin_token
  before_create :create_password_digest

  belongs_to :account
  has_many :appointments

  VALID_EMAIL_REGEX = /\A[\w+\-_.]+@[a-z\d\-_.]+\.[a-z]+\z/i
  validates :first_name,  presence: true,
                          length: { maximum: 50 }
  validates :last_name,   presence: true,
                          length: { maximum: 50 }
  validates :email,       presence: true,
                          length: { minimum: 4, maximum: 100 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }
  validates :password,    presence: true,
                          length: { minimum: 6, maximum: 100 }
  validates :active,      inclusion: { in: [true, false] }

  def name
    first_name + ' ' + last_name
  end

  def authenticate(password_plaintext)
    BCrypt::Password.new(password_digest) == password_plaintext && self
  end

  def User.new_signin_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_password_digest
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine::DEFAULT_COST
      self.password_digest = BCrypt::Password.create(@password, cost: cost)
    end

    def create_signin_token
      self.signin_token = User.encrypt(User.new_signin_token)
    end
end
