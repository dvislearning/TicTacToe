	class Board
		attr_accessor :board_state
		def initialize
			@board_state = {
		   1 => "1",
		   2 => "2",
		   3 => "3",
		   4 => "4",
		   5 => "5",
		   6 => "6",
		   7 => "7",
		   8 => "8",
		   9 => "9"
		            }
		end

		def display_board
		  puts %W(\n
		  	|#{@board_state[1]}|#{@board_state[2]}|#{@board_state[3]}|
		  	|#{@board_state[4]}|#{@board_state[5]}|#{@board_state[6]}|
		  	|#{@board_state[7]}|#{@board_state[8]}|#{@board_state[9]}|
		  	\n)
		end

		def write_board(position, xo)
			@board_state[position] = xo
			display_board
		end

		def spot_empty?(position)
			((@board_state[position] == "X") || (@board_state[position] == "O")) ? false : true
		end	

			def winner?
			winners = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
			container = []
			winners.each do |combo|
				container.clear
				combo.each do |number|
					container << @board_state[number]
				end
				return true if container.all? {|entry| entry == "X"}
				return true if container.all? {|entry| entry == "O"}
			end
			false
		end
		
		def draw?
			square_status = board_state.values
			square_status.all? { |square| square == "X" || square == "O"}
		end								
	end
