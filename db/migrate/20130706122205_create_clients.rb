class CreateClients < ActiveRecord::Migration
  def change
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    create_table :clients do |t|
      t.integer     :account_id,    :null => false
      t.string      :first_name,    :null => false
      t.string      :last_name
      t.date        :birthday
      t.string      :email
      t.string      :telephone_cellular
      t.string      :telephone_home
      t.string      :telephone_office
      t.hstore      :custom_fields

      t.foreign_key :accounts

      t.timestamps
    end

    # TODO: what about a Document Id?
    # Q: Create generic field and localize display name to country?  All searches will happen on this field.
    # Q: Some clients will have a licensa de motorista, others will have and id doc like CPF. problems...
    add_index(:clients, :account_id)
    add_index(:clients, :first_name)
    add_index(:clients, :last_name)
    add_index(:clients, [:first_name, :last_name])
    add_index(:clients, :email, unique: true)
  end
end
