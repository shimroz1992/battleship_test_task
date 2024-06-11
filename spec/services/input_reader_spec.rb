# spec/services/input_reader_spec.rb
require 'rails_helper'

RSpec.describe InputReader, type: :service do
  describe '.read_input' do
    let(:file_path) { 'spec/fixtures/input.txt' }

    context 'with valid input' do
      before do
        allow(File).to receive(:readlines).and_call_original
        allow(File).to receive(:readlines).with(file_path).and_return([
          "5",
          "2",
          "0,0:1,1",
          "0,0:2,2",
          "3",
          "0,0:1,1:2,2",
          "0,0:3,3:4,4"
        ])
      end

      it 'reads input file and returns parsed data' do
        input_data = InputReader.read_input(file_path)
        expect(input_data[:grid_size]).to eq(5)
        expect(input_data[:num_ships]).to eq(2)
        expect(input_data[:player1_ships]).to eq(['0,0', '1,1'])
        expect(input_data[:player2_ships]).to eq(['0,0', '2,2'])
        expect(input_data[:num_missiles]).to eq(3)
        expect(input_data[:player1_moves]).to eq(['0,0', '1,1', '2,2'])
        expect(input_data[:player2_moves]).to eq(['0,0', '3,3', '4,4'])
      end
    end

    context 'with invalid grid size' do
      before do
        allow(File).to receive(:readlines).and_call_original
        allow(File).to receive(:readlines).with(file_path).and_return([
          "10",
          "2",
          "0,0:1,1",
          "0,0:2,2",
          "3",
          "0,0:1,1:2,2",
          "0,0:3,3:4,4"
        ])
      end

      it 'raises an error' do
        expect { InputReader.read_input(file_path) }.to raise_error(RuntimeError, 'Invalid grid size')
      end
    end

    context 'with invalid number of ships' do
      before do
        allow(File).to receive(:readlines).and_call_original
        allow(File).to receive(:readlines).with(file_path).and_return([
          "5",
          "20",
          "0,0:1,1",
          "0,0:2,2",
          "3",
          "0,0:1,1:2,2",
          "0,0:3,3:4,4"
        ])
      end

      it 'raises an error' do
        expect { InputReader.read_input(file_path) }.to raise_error(RuntimeError, 'Invalid number of ships')
      end
    end

    context 'with invalid number of missiles' do
      before do
        allow(File).to receive(:readlines).and_call_original
        allow(File).to receive(:readlines).with(file_path).and_return([
          "5",
          "2",
          "0,0:1,1",
          "0,0:2,2",
          "100",
          "0,0:1,1:2,2",
          "0,0:3,3:4,4"
        ])
      end

      it 'raises an error' do
        expect { InputReader.read_input(file_path) }.to raise_error(RuntimeError, 'Invalid number of missiles')
      end
    end

    context 'with invalid number of moves' do
      before do
        allow(File).to receive(:readlines).and_call_original
        allow(File).to receive(:readlines).with(file_path).and_return([
          "5",
          "2",
          "0,0:1,1",
          "0,0:2,2",
          "3",
          "0,0:1,1",
          "0,0:3,3:4,4"
        ])
      end

      it 'raises an error' do
        expect { InputReader.read_input(file_path) }.to raise_error(RuntimeError, 'Invalid number of moves')
      end
    end

    context 'with invalid positions' do
      before do
        allow(File).to receive(:readlines).and_call_original
        allow(File).to receive(:readlines).with(file_path).and_return([
          "5",
          "2",
          "0,0:10,10",
          "0,0:2,2",
          "3",
          "0,0:1,1:2,2",
          "0,0:3,3:4,4"
        ])
      end

      it 'raises an error' do
        expect { InputReader.read_input(file_path) }.to raise_error(RuntimeError, /Invalid position format or position out of grid boundaries: 10,10/)
      end
    end

    describe '.validate_positions' do
      let(:grid_size) { 5 }

      context 'with valid positions' do
        let(:positions) { ['0,0', '1,1', '2,2'] }

        it 'does not raise an error' do
          expect { InputReader.validate_positions(positions, grid_size) }.not_to raise_error
        end
      end

      context 'with invalid positions' do
        let(:positions) { ['0,0', '10,10', '2,2'] }

        it 'raises an error' do
          expect { InputReader.validate_positions(positions, grid_size) }.to raise_error(RuntimeError, /Invalid position format or position out of grid boundaries: 10,10/)
        end
      end
    end
  end
end