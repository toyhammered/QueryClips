class DatabaseConnection < ActiveRecord::Base
  has_many :saved_queries
  belongs_to :user

  def tables
    SchemaExplorer.new(database_connection: self).tables
  end

  def table_schema(table)
    SchemaExplorer.new(database_connection: self).table_schema(table)
  end

  def test
    self.tables
    self.table_schema
    return true
  rescue Exception => e
    return false
  end
end
