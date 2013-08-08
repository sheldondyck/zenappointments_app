class RecreateIndexEmailFromClients < ActiveRecord::Migration
  def change
    remove_index :clients, name: 'index_clients_on_email'
    add_index :clients, :email
  end
end
