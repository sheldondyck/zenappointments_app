class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :account_id,    :null => false
      t.integer :user_id,       :null => false
      t.integer :employee_id,   :null => true
      t.integer :client_id,     :null => false
      t.datetime :time,         :null => false
      t.integer :duration,      :null => false

      t.foreign_key :accounts
      t.foreign_key :users
      t.foreign_key :employees
      t.foreign_key :clients

      t.timestamps
    end

    add_index(:appointments, :account_id)
    add_index(:appointments, :user_id)
    add_index(:appointments, :employee_id)
    add_index(:appointments, :client_id)
    add_index(:appointments, [:account_id, :time])
    add_index(:appointments, [:account_id, :employee_id, :time])
  end
end
