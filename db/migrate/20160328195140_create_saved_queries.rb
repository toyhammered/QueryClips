class CreateSavedQueries < ActiveRecord::Migration
  def change
    create_table :saved_queries do |t|
      t.string :name
      t.string :query

      t.timestamps
    end
  end
end
