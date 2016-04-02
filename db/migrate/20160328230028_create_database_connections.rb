class CreateDatabaseConnections < ActiveRecord::Migration
  def change
    create_table :database_connections do |t|
      t.string :host
      t.integer :port
      t.string :name
      t.string :dbname
      t.string :user
      t.string :password

      t.timestamps
    end
  end
end
