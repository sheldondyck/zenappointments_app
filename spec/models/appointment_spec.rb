# == Schema Information
#
# Table name: appointments
#
#  id          :integer          not null, primary key
#  account_id  :integer          not null
#  user_id     :integer          not null
#  employee_id :integer          not null
#  client_id   :integer          not null
#  time        :datetime
#  duration    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Appointment do
  pending "add some examples to (or delete) #{__FILE__}"
end
