class CreateAccounts < ActiveRecord::Migration
  def change
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    create_table :accounts do |t|
      t.string      :company_name,  :null => false
      t.hstore      :configuration
      t.boolean     :active,        :null => false

      t.timestamps
    end

    add_index :accounts, :company_name, unique: true
  end
end
