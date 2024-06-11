class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :player1, foreign_key: { to_table: :players }
      t.references :player2, foreign_key: { to_table: :players }
      t.integer :player1_hits
      t.integer :player2_hits
      t.string :result

      t.timestamps
    end
  end
end
