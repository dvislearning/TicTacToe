require 'spec_helper'
require 'tictactoe'

describe 'Engine' do
	before :each do
		@player1 = TicTacToe::Player1.new(computer = false, name = "John", x_or_o = 'O')
		@player2 = TicTacToe::Player2.new(computer = false, name = "Jane", x_or_o = 'X')
		@board = TicTacToe::Board.new
		@engine = TicTacToe::Engine.new(@player1,@player2,@board)
	end
	describe "#initialize" do
		it "is expected to correctly assign @player_x and @player_y", :engine => true do
			expect(@engine.player_x.x_or_o).to eq(@engine.player2.x_or_o)
		end
	end
	describe "#winner?" do
		context 'when x wins'
			it "returns true with winning horizontal combination", :engine => true  do
				@board.board_state = { 1 => "X", 2 => "X", 3 => "X", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(true)
			end
			it "returns true with winning vertical combination", :engine => true  do
				@board.board_state = { 1 => "X", 2 => "2", 3 => "3", 4 => "X", 5 => "5", 6 => "6", 7 => "X", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(true)
			end	
			it "returns true with winning diagonal combination", :engine => true  do
				@board.board_state = { 1 => "1", 2 => "2", 3 => "X", 4 => "4", 5 => "X", 6 => "6", 7 => "X", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(true)
			end
			it "returns false when line is occupied by different marks", :engine => true  do
				@board.board_state = { 1 => "X", 2 => "2", 3 => "3", 4 => "O", 5 => "5", 6 => "6", 7 => "X", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(false)				
			end					
			it "returns false when no lines are occupied", :engine => true  do
				@board.board_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(false)
			end
			it "returns false when draw occurs", :engine => true  do
				@board.board_state = { 1 => "X", 2 => "O", 3 => "X", 4 => "X", 5 => "O", 6 => "X", 7 => "O", 8 => "X", 9 => "O"}
				expect(@board.winner?).to eq(false)
			end	
		end
		context 'when O wins' do
			it "returns true with winning horizontal combination", :engine => true  do
				@board.board_state = { 1 => "O", 2 => "O", 3 => "O", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(true)
			end
			it "returns true with winning vertical combination", :engine => true  do
				@board.board_state = { 1 => "O", 2 => "2", 3 => "3", 4 => "O", 5 => "5", 6 => "6", 7 => "O", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(true)
			end	
			it "returns true with winning diagonal combination", :engine => true  do
				@board.board_state = { 1 => "O", 2 => "2", 3 => "3", 4 => "4", 5 => "O", 6 => "6", 7 => "7", 8 => "8", 9 => "O"}
				expect(@board.winner?).to eq(true)
			end	
		end	
		context 'when neither X nor O win'	do
			it "returns false when line is occupied by different marks", :engine => true  do
				@board.board_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "O", 5 => "X", 6 => "O", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(false)				
			end					
			it "returns false when no lines are occupied", :engine => true  do
				@board.board_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.winner?).to eq(false)
			end
			it "returns false when draw occurs", :engine => true  do
				@board.board_state = { 1 => "X", 2 => "O", 3 => "X", 4 => "X", 5 => "O", 6 => "X", 7 => "O", 8 => "X", 9 => "O"}
				expect(@board.winner?).to eq(false)
			end
		end		
end

describe 'Board' do
	before :each do
		@board = TicTacToe::Board.new
	end
	
	describe '#write_board' do
		context 'when board is empty' do
			it 'places a mark on square space 5', :board => true do
				@board.write_board(5, "X")
				expect(@board.board_state).to eq({ 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "X", 6 => "6", 7 => "7", 8 => "8", 9 => "9"})
			end
		end
		context 'when other marks are present' do
			it 'places a mark square space 2', :board => true do
				@board.board_state = { 1 => "O", 2 => "2", 3 => "O", 4 => "4", 5 => "X", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				@board.write_board(2, "X")
				expect(@board.board_state).to eq({ 1 => "O", 2 => "X", 3 => "O", 4 => "4", 5 => "X", 6 => "6", 7 => "7", 8 => "8", 9 => "9"})
			end
		end
	end
	
	describe 'spot_empty?' do
		context 'when checking Xs ' do
			it 'returns true when checking empty square space 3', :board => true do
				@board.board_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.spot_empty?(3)).to eq(true)
			end
			it 'returns false when checking square space 3 filled with X', :board => true do
				@board.board_state = { 1 => "1", 2 => "2", 3 => "X", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.spot_empty?(3)).to eq(false)
			end
			it 'returns false when checking square space 6 filled with O', :board => true do
				@board.board_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "O", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.spot_empty?(6)).to eq(false)
			end			
		end
		context 'when checking Os ' do
			it 'returns false when checking square space 3 filled with O', :board => true do
				@board.board_state = { 1 => "O", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.spot_empty?(1)).to eq(false)
			end
			it 'returns false when checking square space 4 filled with X', :board => true do
				@board.board_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "X", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
				expect(@board.spot_empty?(4)).to eq(false)
			end			
		end		
	end
end


#allow_any_instance_of(Kernel).to receive(:gets).and_return("1\n")


