class AddUsersToSavedQueries < ActiveRecord::Migration
  def change
    add_column :saved_queries, :user_id, :integer, null: false, default: 1
  end
end
