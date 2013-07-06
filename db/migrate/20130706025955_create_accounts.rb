class CreateAccounts < ActiveRecord::Migration
  def change
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    create_table :accounts do |t|
      t.string :owner_first_name, :null => false
      t.string :owner_last_name, :null => false
      t.string :company_name, :null => false
      t.string :email, :null => false
      t.hstore :configuration
      t.boolean :active, :null => false

      t.timestamps
    end

    add_index(:accounts, :company_name)
  end
end
