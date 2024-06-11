class CreateShips < ActiveRecord::Migration[6.1]
  def change
    create_table :ships do |t|
      t.integer :x
      t.integer :y
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
