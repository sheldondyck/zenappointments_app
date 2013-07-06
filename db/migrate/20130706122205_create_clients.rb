class CreateClients < ActiveRecord::Migration
  def change
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    create_table :clients do |t|
      t.integer :account_id
      t.foreign_key :accounts
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :email
      t.string :telefone_celular
      t.string :telefone_home
      t.string :telefone_office
      t.hstore :custom_fields

      t.timestamps
    end

    # TODO: what about a Document Id?
    # Q: Create generic field and localize display name to country?  All searches will happen on this field.
    # Q: Some clients will have a licensa de motorista, others will have and id doc like CPF. problems...
    add_index(:clients, :first_name)
    add_index(:clients, :last_name)
    add_index(:clients, [:first_name, :last_name])
  end
end
