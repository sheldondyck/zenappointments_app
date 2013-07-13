# == Schema Information
#
# Table name: clients
#
#  id               :integer          not null, primary key
#  account_id       :integer          not null
#  first_name       :string(255)      not null
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

require 'spec_helper'

describe Client do
end
