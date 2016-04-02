class AddDatabaseConnectionIdToSavedQueries < ActiveRecord::Migration
  def change
    add_column :saved_queries, :database_connection_id, :integer, null: false, default: 1
  end
end
