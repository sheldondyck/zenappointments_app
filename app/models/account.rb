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
  attr_accessor :name
  attr_accessor :email
  attr_accessor :password

  #after_create :create_user

  has_many :users,        dependent: :delete_all
  has_many :employees,    dependent: :delete_all
  has_many :clients,      dependent: :delete_all
  has_many :appointments, dependent: :delete_all

  validates :company_name, presence: true,
                           length: { maximum: 100 },
                           uniqueness: { case_sensitive: false }
  validates :active,       inclusion: { in: [true, false] }

  #def create_user
  #  puts "create_user account_id: #{id} #{self.first_name} f#{first_name}"
  #end

  def self.current_id=(id)
    Thread.current[:account_id] = id
  end

  def self.current_id
    Thread.current[:account_id]
  end

  def self.slots_per_hour
    # Valid values: 2, 3, 4, 5, 6, 8
    # Invalid values: 7
    # TODO: should we allow 3, 5?
    4
  end

  # TODO a lot of these config function will have to be changed to non-static
  def self.minutes_per_slot
    (60 / Account.slots_per_hour)
  end

  def self.starting_hour
    6
  end

  def self.ending_hour
    20
  end

  def self.appointment_duration
    60
  end

  def self.start_of_week
    :monday
    #:tuesday
    #:sunday
  end

  def self.time_zone
    'Tokyo'
  end

  def is_demo?
    # TODO this value will be true if account.zen_product_price_id == null
    false
  end

  def remaining_demo_days
    # TODO the number 30 should come from zen_product_list
    (30 - ((Time.zone.now - created_at) / 1.day)).to_i + 1
  end
end
