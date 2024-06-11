class InputReader
  def self.read_input(file_path)
    lines = File.readlines(file_path).map(&:strip)
    grid_size = lines[0].to_i
    raise 'Invalid grid size' unless grid_size.between?(1, 9)

    num_ships = lines[1].to_i
    raise 'Invalid number of ships' unless num_ships.between?(1, (grid_size ** 2) / 2)

    player1_ships = lines[2].split(':').map { |position| position.strip }
    player2_ships = lines[3].split(':').map { |position| position.strip }
    num_missiles = lines[4].to_i
    raise 'Invalid number of missiles' unless num_missiles.between?(1, 99)

    player1_moves = lines[5].split(':').map { |position| position.strip }
    player2_moves = lines[6].split(':').map { |position| position.strip }
    raise 'Invalid number of moves' unless player1_moves.size == num_missiles && player2_moves.size == num_missiles

    validate_positions(player1_ships, grid_size)
    validate_positions(player2_ships, grid_size)
    validate_positions(player1_moves, grid_size)
    validate_positions(player2_moves, grid_size)

    {
      grid_size: grid_size,
      num_ships: num_ships,
      player1_ships: player1_ships,
      player2_ships: player2_ships,
      num_missiles: num_missiles,
      player1_moves: player1_moves,
      player2_moves: player2_moves
    }
  end

  def self.validate_positions(positions, grid_size)
    positions.each do |position|
      if position.is_a?(Array) # Check if the position is already an array of integers
        x, y = position
      else
        x, y = position.split(',').map(&:to_i)
      end

      unless x && y && x.between?(0, grid_size - 1) && y.between?(0, grid_size - 1)
        raise "Invalid position format or position out of grid boundaries: #{position}"
      end
    end
  end
end
