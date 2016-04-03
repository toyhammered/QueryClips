class MakeQueriesText < ActiveRecord::Migration
  def up
    change_column :saved_queries, :query, :text
  end

  def down
    change_column :saved_queries, :query, :string
  end
end
