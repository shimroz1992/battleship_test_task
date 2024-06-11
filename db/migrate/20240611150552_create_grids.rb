class CreateGrids < ActiveRecord::Migration[7.1]
  def change
    create_table :grids do |t|
      t.integer :size

      t.timestamps
    end
  end
end
