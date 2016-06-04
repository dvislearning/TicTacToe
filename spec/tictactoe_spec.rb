require 'spec_helper'
require 'tictactoe'

describe 'Board' do
	before :each do
		@board = TicTacToe::Board.new
		@square_state = @board.square_state
	end

	describe '#write_board' do
	 it 'changes square_state number to an X or 0 depending on user input' do
		 @board.write_board(6, 'X') 
		 expect(@square_state[6]).to eq("X")
	 end	 	
	end
	describe '#spot_empty?' do
	 it 'returns true if board space occupied by neither X nor O' do
		expect(@board.spot_empty?(1)).to be(true)
	 end 
 	 it 'returns flase if board space is occupied by an 0' do
 	 	@board.write_board(9, 'O')
	 	expect(@board.spot_empty?(9)).to be(false)
	 end
 	 it 'returns flase if board space is occupied by an X' do
 	 	@board.write_board(9, 'X')
	 	expect(@board.spot_empty?(9)).to be(false)
	 end 	 	
	end
	describe '#has_winner?' do
	 it 'returns true if board spaces are occupied by three Xs along a row' do
		@board.write_board(1, 'X')
		@board.write_board(2, 'X')
		@board.write_board(3, 'X')
		expect(@board.has_winner?("X")).to be(true)
	 end
 	 it 'returns true if board spaces are occupied by three Xs along a diagonal' do
 	 	@board.write_board(1, 'X')
 	 	@board.write_board(5, 'X')
 	 	@board.write_board(9, 'X')
	 	expect(@board.has_winner?('X')).to be(true)
   end
 	 it 'returns true if board spaces are occupied by three Xs along a column' do
 	 	@board.write_board(3, 'X')
 	 	@board.write_board(6, 'X')
 	 	@board.write_board(9, 'X')
	 	expect(@board.has_winner?('X')).to be(true)
   end
 	 it 'returns false when a column is empty' do
	 	expect(@board.has_winner?('O')).to be(false)
   end   
 	 it 'returns false when a row is one O away from winning' do
 	 	@board.write_board(7, 'O')
 	 	@board.write_board(8, 'O')
	 	expect(@board.has_winner?('O')).to be(false)
   end
 	 it 'returns false when a diagonal is occupied with both Xs and Os' do
 	 	@board.write_board(3, 'O')
 	 	@board.write_board(5, 'X')
 	 	@board.write_board(7, 'O')
	 	expect(@board.has_winner?('O')).to be(false)
   end
 end
end

describe 'Player1' do
	before :all do
		RSpec::Mocks.with_temporary_scope do
			#$stdin_name = StringIO.new("filler_name_string\n")
			 #$stdin = StringIO.new("filler_xo_string\n")
			@player = TicTacToe::Player1.new
			#@player.instance_variable_set(:@name, "Ronnie")
			@player.instance_variable_set(:@x_or_o, "X\n")
		end
	end
	describe '#initialize' do
		# it 'describes initialize' do
		# 	expect(@player.name).to eq("Ronnie")
		# end
		it 'describes initialize' do
			expect(@player.x_or_o).to eq("X")
		end		
	end
	# describe '#get_name' do
	#  it 'sets Player1 name to user input' do
	# 	 player = TicTacToe::Player1.new
	# 	 player.stub(:STDIN.gets) {"Ronnie"}
	# 	 expect(player.get_name).to eq("Ronnie")
	#  end	 	
 	# end
end

#allow_any_instance_of(Kernel).to receive(:gets).and_return("1\n")


