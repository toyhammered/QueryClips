class AddSlugToSavedQueries < ActiveRecord::Migration
  def change
    add_column :saved_queries, :slug, :string, unique: true
    add_index :saved_queries, :slug, unique: true
  end
end
