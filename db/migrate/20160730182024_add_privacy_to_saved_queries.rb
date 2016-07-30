class AddPrivacyToSavedQueries < ActiveRecord::Migration
  def change
    add_column :saved_queries, :privacy, :string, null: false, default: 'public'
  end
end
