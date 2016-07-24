class AddUserIdToDatabaseConnections < ActiveRecord::Migration
  def up
    add_column :database_connections, :user_id, :integer, null: false, default: 1
    add_column :database_connections, :username, :string
    DatabaseConnection.all.each do |dbc|
      dbc.username = dbc.user
      dbc.save!
    end
    remove_column :database_connections, :user
  end

  def down
    remove_column :database_connections, :user_id
    add_column :database_connections, :user, :string
    DatabaseConnection.all.each do |dbc|
      dbc.user = dbc.username
      dbc.save!
    end
    remove_column :database_connections, :username
  end
end
