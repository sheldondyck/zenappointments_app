# == Schema Information
#
# Table name: appointments
#
#  id          :integer          not null, primary key
#  account_id  :integer          not null
#  user_id     :integer          not null
#  employee_id :integer
#  client_id   :integer          not null
#  time        :datetime         not null
#  duration    :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Appointment < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :employee
  belongs_to :client

  validates :time,      presence:   true
  validates :duration,  presence:   true,
                        inclusion:  15..(24*60)
end
