class AddSlugToVisualizations < ActiveRecord::Migration
  def up
    add_column :visualizations, :slug, :string, unique: true
    add_index :visualizations, :slug, unique: true

    Visualization.find_each(&:save)
  end

  def down
    remove_column :visualizations, :slug
  end
end
