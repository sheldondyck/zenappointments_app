class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :account_id, :null => false
      t.foreign_key :accounts
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.string :password, :null => false
      t.string :password_digest, :null => false
      t.boolean :account_administrator, :null => false
      t.boolean :active, :null => false

      t.timestamps
    end

    add_index(:users, :account_id)
    add_index(:users, :email)
  end
end
