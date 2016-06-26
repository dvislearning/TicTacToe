require 'spec_helper'
require 'board'

describe 'Board' do
	before :each do
		@board = TicTacToe::Board.new
	end

	describe "#initialize" do 
		it "initializes a blank game board", :refactor => true do
			test_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}	
			expect(@board.board_state).to eq(test_state)
		end
	end

	describe "#write_board" do 
		it "changes board_state to X or O", :refactor => true do
			test_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "X", 5 => "5", 6 => "O", 7 => "7", 8 => "8", 9 => "9"}
			@board.write_board(4, "X")
			@board.write_board(6, "O")
			expect(@board.board_state).to eq(test_state)
		end
	end	

	describe "#spot_empty?" do 
		it "returns false when trying to write into occupied space 4", :refactor => true do
			test_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "X", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
			@board.write_board(4, "X")
			expect(@board.spot_empty?(4)).to eq(false)
		end
	end

	describe "#spot_empty?" do 
		it "returns true when trying to write into empty space 8", :refactor => true do
			test_state = { 1 => "1", 2 => "2", 3 => "3", 4 => "X", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
			expect(@board.spot_empty?(8)).to eq(true)
		end
	end

	describe "#winner?" do
		context "with winner" do
			it "returns true there is a horizontal winner", :refactor => true do
				@board.write_board(1, "X")
				@board.write_board(2, "X")
				@board.write_board(3, "X")
				expect(@board.winner?).to eq(true)
			end

			it "returns true there is a vertical winner", :refactor => true do
				@board.write_board(2, "O")
				@board.write_board(5, "O")
				@board.write_board(8, "O")
				expect(@board.winner?).to eq(true)
			end	

			it "returns true there is a right diagonal winner", :refactor => true do
				@board.write_board(1, "O")
				@board.write_board(5, "O")
				@board.write_board(9, "O")
				expect(@board.winner?).to eq(true)
			end

			it "returns true there is a left diagonal winner", :refactor => true do
				@board.write_board(3, "O")
				@board.write_board(5, "O")
				@board.write_board(7, "O")
				expect(@board.winner?).to eq(true)
			end									
		end

		context "with no winner" do
			it "returns false with empty board", :refactor => true do
				expect(@board.winner?).to eq(false)
			end

			it "returns false when vertical is occupied by different marks", :refactor => true do
				@board.write_board(2, "O")
				@board.write_board(5, "X")
				@board.write_board(8, "O")
				expect(@board.winner?).to eq(false)
			end	

			it "returns false when right diagonal is not fully occupied", :refactor => true do
				@board.write_board(1, "O")
				@board.write_board(5, "O")
				@board.write_board(9, "9")
				expect(@board.winner?).to eq(false)
			end

			it "returns false when left diagonal is occupied by different marks", :refactor => true do
				@board.write_board(3, "X")
				@board.write_board(5, "O")
				@board.write_board(7, "O")
				expect(@board.winner?).to eq(false)
			end									
		end		
	end	

	describe "#draw?" do 
		it "returns true when board is filled", :refactor => true do
			1.upto(9) { |position| @board.write_board(position, "X")}
			expect(@board.draw?).to eq(true)
		end

		it "returns false when board is not completely filled", :refactor => true do
			2.upto(9) { |position| @board.write_board(position, "X")}
			expect(@board.draw?).to eq(false)
		end		
	end				
end

