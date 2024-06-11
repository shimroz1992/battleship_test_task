# app/services/game_engine.rb
class GameEngine
  def initialize(grid_size, player1_ships, player2_ships, player1_moves, player2_moves)
    @grid_size = grid_size
    @player1_ships = player1_ships
    @player2_ships = player2_ships
    @player1_moves = player1_moves
    @player2_moves = player2_moves
    @player1_grid = Array.new(grid_size) { Array.new(grid_size, '_') }
    @player2_grid = Array.new(grid_size) { Array.new(grid_size, '_') }
    place_ships(@player1_ships, @player1_grid)
    place_ships(@player2_ships, @player2_grid)
  end

  def place_ships(ship_positions, grid)
    ship_positions.each do |position|
      if position.is_a?(Array)
        x, y = position
      else
        x, y = position.split(',').map(&:to_i)
      end
      grid[x][y] = 'B'
    end
  end

  def play_game
    puts "Player 1 Ships: #{@player1_ships}"
    puts "Player 2 Ships: #{@player2_ships}"
    puts "Player 1 Moves: #{@player1_moves}"
    puts "Player 2 Moves: #{@player2_moves}"

    player1_hits = execute_moves(@player1_moves, @player2_grid)
    player2_hits = execute_moves(@player2_moves, @player1_grid)
    result = determine_winner(player1_hits, player2_hits)

    save_result(player1_hits, player2_hits, result)
    output_result(player1_hits, player2_hits, result)
  end

  def execute_moves(moves, opponent_grid)
    hits = 0
    moves.each do |move|
      x, y = move.split(',').map(&:to_i)
      if opponent_grid[x][y] == 'B'
        opponent_grid[x][y] = 'X'
        hits += 1
      else
        opponent_grid[x][y] = 'O'
      end
    end
    hits
  end

  def determine_winner(player1_hits, player2_hits)
    if player1_hits > player2_hits
      "Player 1 wins"
    elsif player2_hits > player1_hits
      "Player 2 wins"
    else
      "It is a draw"
    end
  end

  def save_result(player1_hits, player2_hits, result)
    player1 = Player.find_or_create_by(name: "Player 1")
    player2 = Player.find_or_create_by(name: "Player 2")

    Game.create!(
      player1: player1,
      player2: player2,
      player1_hits: player1_hits,
      player2_hits: player2_hits,
      result: result
    )
  end

  def output_result(player1_hits, player2_hits, result)
    File.open('output.txt', 'w') do |file|
      file.puts "Player1 Grid:"
      @player1_grid.each { |row| file.puts row.join(' ') }
      file.puts "\nPlayer2 Grid:"
      @player2_grid.each { |row| file.puts row.join(' ') }
      file.puts "\nPlayer 1 Hits: #{player1_hits}"
      file.puts "Player 2 Hits: #{player2_hits}"
      file.puts "\nGame Result: #{result}"
    end
  end
end
