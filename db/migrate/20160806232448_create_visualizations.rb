class CreateVisualizations < ActiveRecord::Migration
  def change
    create_table :visualizations do |t|
      t.integer :saved_query_id, null: false
      t.string :name, null: false
      t.text :code

      t.timestamps
    end
  end
end
