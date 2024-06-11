namespace :battleship do
  desc "Play a game of Battleship"
  task :play => :environment do
    input = InputReader.read_input('input.txt')
    game_engine = GameEngine.new(
      input[:grid_size],
      input[:player1_ships],
      input[:player2_ships],
      input[:player1_moves],
      input[:player2_moves]
    )
    game_engine.play_game
  end
end
