module TicTacToe

	class StartGame
		def initialize
			puts "Welcome to Tic Tac Toe!"
			puts ""
			puts "Please Select An Option"
			puts "------------------------------"
			puts "1: Human vs Human"
			puts "2: Human vs Computer (Easy)"
			puts "3: Human vs Computer (Hard)"
			puts "4: Exit"
			puts "------------------------------"
			puts ""

			answer = gets.chomp.to_s

			if answer =~ (/[1234]/)
				case answer
				when "1"
					HumanHumanGame.new
				when "2"
					HumanCompEasyGame.new
				when "3"
					HumanCompHardGame.new
				when "4"
					puts "Exiting Program.  Bye!"
					puts ""
					exit
				else
					puts "Invalid Input!"
					puts "Please enter either 1, 2, 3, or 4"
					StartGame.new
				end
			end
		end
	end

#Creates new game board and keeps track of its states.
class Board
	attr_accessor :square_state
	def initialize
		@square_state = {
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
	  puts ""         
   	puts "|#{@square_state[1]}|#{@square_state[2]}|#{@square_state[3]}|"
	  puts "|#{@square_state[4]}|#{@square_state[5]}|#{@square_state[6]}|"
	  puts "|#{@square_state[7]}|#{@square_state[8]}|#{@square_state[9]}|"
	  puts ""
	end

	def write_board(position, xo)
		@square_state[position] = xo
		display_board
	end

	def spot_empty?(position)
		((@square_state[position] == "X") || (@square_state[position] == "O")) ? false : true
	end

	def has_winner?(xo)
		winners = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
		container = []
		winners.each do |combo|
			container.clear
			combo.each do |number|
				container << @square_state[number]
			end
			return true if container.all? {|entry| entry == xo}
		end
		false
	end
end



#Gets name of Player 1 and asks if Player 1 wants to play as X or O.
	class Player1
		attr_reader :name, :x_or_o
		def initialize(computer = false)
			@computer = computer
			@name = get_name
			@x_or_o = get_x_or_o
		end

		def get_name
			if @computer == true
				"CPU"
			elsif @computer == false
				print "Please Enter Your Name: "
				gets.chomp
			end
		end

		def get_x_or_o
			print "Would you like to play as X or O?: "
			choice = gets.chomp.capitalize
			if choice =~ (/[^XO]/)
				puts "Invalid Selection.  Please Type Either X or The Letter O"
				get_x_or_o
			else
				choice
			end
		end

		def make_move(board, xo)
			if @computer == true
				computer_move(board, xo)
			else
				puts "Select a number to place an #{xo} in."
				entry = gets.chomp.to_i
				if entry.to_s =~ (/[1-9]/) && entry.to_s.length == 1 && board.spot_empty?(entry)
					entry
				else
					puts "Invalid entry.  Please enter a number between 1 - 9. On an Empty Square."
					make_move(board, xo)
				end
			end
		end

		def computer_move(board, xo)
			puts_thinking
			loop do
				choice = rand(1..9)
				if board.spot_empty?(choice)
					return choice
				end
			end
		end

		def puts_thinking
			puts "Thinking..."
			sleep(1.5)
		end
	end

#Gets name of Player 2.
	class Player2 < Player1
		def initialize(computer = false)
			@computer = computer
			@name = get_name
		end
	end

#Assigns players as X or O, and runs game logic while game is active.
	class Game
		def initialize
			@player1 = Player1.new(false)
			@player2 = Player2.new(false)
			set_players
		end

		def set_players
			@player_x = @player1.x_or_o == "X" ? @player1 : @player2
			@player_o = @player_x == @player1 ? @player2 : @player1
			puts_player_info
			@current_game = Board.new
			@current_game.display_board
			run_game(@current_game, @player_x, @player_o)
		end

		def puts_player_info
			puts "(X) #{@player_x.name}"
			puts "vs".rjust(6)
			puts "(O) #{@player_o.name}"
			puts ""
		end

		def run_game(board, player_x, player_o)
			moves = 0
		
			5.times do
				if winner?(board, "O", player_o)
					break
				else
					selection_x = @player_x.make_move(@current_game, "X")
					@current_game.write_board(selection_x, "X")
					moves += 1
				end
				if winner?(board, "X", player_x) || draw?(moves)
					break
				else
					selection_o = @player_o.make_move(@current_game, "O")
					@current_game.write_board(selection_o, "O")
					moves += 1
				end 
			end
		end

		def draw?(moves)
			if moves == 9
				puts "This Game is a Draw!"
				true
			end
		end

		def winner?(board, xo, player)
			if board.has_winner?(xo)
				puts "#{player.name} Has Won The Game!"
				true
			else
				false
			end
		end
	end

	class HumanHumanGame < Game
	end

	class HumanCompEasyGame < Game
		def initialize
			@player1 = Player1.new(false)
			@player2 = Player2.new(true)
			set_players
		end
	end

end

TicTacToe::StartGame.new

