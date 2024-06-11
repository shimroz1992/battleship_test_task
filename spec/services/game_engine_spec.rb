# spec/services/game_engine_spec.rb
require 'rails_helper'

RSpec.describe GameEngine do
  let(:grid_size) { 5 }
  let(:player1_ships) { [[0, 0], [1, 1]] }
  let(:player2_ships) { [[0, 0], [2, 2]] }
  let(:player1_moves) { ['0,0', '1,1', '2,2'] }
  let(:player2_moves) { ['0,0', '3,3'] }
  let(:game_engine) { GameEngine.new(grid_size, player1_ships, player2_ships, player1_moves, player2_moves) }

  describe '#initialize' do
    it 'initializes with grid size, player ships, and moves' do
      expect(game_engine.instance_variable_get(:@grid_size)).to eq(grid_size)
      expect(game_engine.instance_variable_get(:@player1_ships)).to eq(player1_ships)
      expect(game_engine.instance_variable_get(:@player2_ships)).to eq(player2_ships)
      expect(game_engine.instance_variable_get(:@player1_moves)).to eq(player1_moves)
      expect(game_engine.instance_variable_get(:@player2_moves)).to eq(player2_moves)
    end

    it 'places the ships on the grids' do
      player1_grid = game_engine.instance_variable_get(:@player1_grid)
      player2_grid = game_engine.instance_variable_get(:@player2_grid)
      
      expect(player1_grid[0][0]).to eq('B')
      expect(player1_grid[1][1]).to eq('B')
      expect(player2_grid[0][0]).to eq('B')
      expect(player2_grid[2][2]).to eq('B')
    end
  end

  describe '#place_ships' do
    it 'places ships at the correct positions' do
      grid = Array.new(grid_size) { Array.new(grid_size, '_') }
      game_engine.place_ships(player1_ships, grid)
      expect(grid[0][0]).to eq('B')
      expect(grid[1][1]).to eq('B')
    end
  end

  describe '#execute_moves' do
    it 'updates the opponent grid correctly and counts hits' do
      player1_grid = game_engine.instance_variable_get(:@player1_grid)
      hits = game_engine.execute_moves(player2_moves, player1_grid)
      expect(hits).to eq(1)
      expect(player1_grid[0][0]).to eq('X')
      expect(player1_grid[3][3]).to eq('O')
    end
  end

  describe '#determine_winner' do
    it 'determines the correct winner' do
      expect(game_engine.determine_winner(2, 1)).to eq('Player 1 wins')
      expect(game_engine.determine_winner(1, 2)).to eq('Player 2 wins')
      expect(game_engine.determine_winner(1, 1)).to eq('It is a draw')
    end
  end

  describe '#play_game' do
    before do
      allow(game_engine).to receive(:save_result)
      allow(game_engine).to receive(:output_result)
    end

    it 'plays the game and determines the result' do
      expect(game_engine).to receive(:save_result).with(2, 1, 'Player 1 wins')
      expect(game_engine).to receive(:output_result).with(2, 1, 'Player 1 wins')
      game_engine.play_game
    end
  end

  describe '#save_result' do
    it 'saves the game result' do
      player1 = Player.create(name: 'Player 1')
      player2 = Player.create(name: 'Player 2')
      expect {
        game_engine.save_result(2, 1, 'Player 1 wins')
      }.to change { Game.count }.by(1)
      game = Game.last
      expect(game.player1).to eq(player1)
      expect(game.player2).to eq(player2)
      expect(game.player1_hits).to eq(2)
      expect(game.player2_hits).to eq(1)
      expect(game.result).to eq('Player 1 wins')
    end
  end

  describe '#output_result' do
    it 'outputs the result to a file' do
      allow(File).to receive(:open).with('output.txt', 'w')
      game_engine.output_result(2, 1, 'Player 1 wins')
      expect(File).to have_received(:open).with('output.txt', 'w')
    end
  end
end
