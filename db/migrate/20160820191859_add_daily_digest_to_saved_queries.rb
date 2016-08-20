class AddDailyDigestToSavedQueries < ActiveRecord::Migration
  def change
    add_column :saved_queries, :daily_digest, :boolean, null: false, default: false
  end
end
