class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :account_id, :null => false
      t.foreign_key :accounts
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.boolean :active, :null => false

      t.timestamps
    end

    add_index(:employees, :account_id)
  end
end
