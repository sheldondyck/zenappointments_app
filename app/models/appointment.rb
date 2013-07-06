class Appointment < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :employee
  belongs_to :client
end
