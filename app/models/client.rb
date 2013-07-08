# == Schema Information
#
# Table name: clients
#
#  id               :integer          not null, primary key
#  account_id       :integer
#  first_name       :string(255)
#  last_name        :string(255)
#  birthday         :date
#  email            :string(255)
#  telefone_celular :string(255)
#  telefone_home    :string(255)
#  telefone_office  :string(255)
#  custom_fields    :hstore
#  created_at       :datetime
#  updated_at       :datetime
#

class Client < ActiveRecord::Base
  belongs_to :account
end
