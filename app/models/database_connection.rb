class DatabaseConnection < ActiveRecord::Base
  has_many :saved_queries

  def tables
    SchemaExplorer.new(database_connection: self).tables
  end

  def table_schema(table)
    SchemaExplorer.new(database_connection: self).table_schema(table)
  end
end
