class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :account_id
      t.foreign_key :accounts
      t.string :first_name
      t.string :last_name
      t.boolean :active

      t.timestamps
    end
  end
end
