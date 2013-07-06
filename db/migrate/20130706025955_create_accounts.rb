class CreateAccounts < ActiveRecord::Migration
  def change
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    create_table :accounts do |t|
      t.string :owner_first_name
      t.string :owner_last_name
      t.string :company_name
      t.string :email
      t.hstore :configuration
      t.boolean :active

      t.timestamps
    end

    add_index(:accounts, :company_name)
  end
end
