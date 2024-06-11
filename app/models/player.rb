class Player < ApplicationRecord
  has_many :game_results_as_player1, class_name: 'GameResult', foreign_key: 'player1_id'
  has_many :game_results_as_player2, class_name: 'GameResult', foreign_key: 'player2_id'
end
