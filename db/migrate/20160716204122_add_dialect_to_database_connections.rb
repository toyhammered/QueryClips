class AddDialectToDatabaseConnections < ActiveRecord::Migration
  def change
    add_column :database_connections, :dialect, :string, default: "PostgreSQL", null: false, blank: false
  end
end
