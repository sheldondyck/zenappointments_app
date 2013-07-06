class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :account_id
      t.foreign_key :accounts
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :password_digest
      t.boolean :account_administrator
      t.boolean :active

      t.timestamps
    end

    add_index(:users, :email)
  end
end
