module TicTacToe

	class StartGame
		def initialize
			puts_start_message
			answer = $stdin.gets.chomp.to_s
			select_game(answer)
		end
		
		def puts_start_message
			puts "Welcome to Tic Tac Toe!"
			puts ""
			puts "Please Select An Option"
			puts "------------------------------"
			puts "1: Human vs Human"
			puts "2: Human vs Computer (Easy)"
			puts "3: Exit"
			puts "------------------------------"
			puts ""
		end

		def select_game(answer)
			if answer =~ (/[123]/)
				case answer
				when "1"
					HumanHumanGame.new
				when "2"
					HumanCompEasyGame.new
				when "3"
					puts "Exiting Program.  Bye!"
					puts ""
					exit
				else
					puts "Invalid Input!"
					puts "Please enter either 1, 2, or 3"
					StartGame.new
				end
			end
		end
	end

	class Engine
		attr_reader :player1, :player2, :player_x, :player_o
		attr_accessor :board_state
		def initialize(player1, player2, board)
			@player1 = player1
			@player2 = player2
			@player_x = @player1.x_or_o == "X" ? @player1 : @player2
			@player_o = @player2.x_or_o == "O" ? @player2 : @player1
			@board_state = board
		end	

		def draw?(moves)
			moves == 9
		end

		def declare_draw_message
			puts "The Contest is a Draw!"
		end

		def display_win_message(xo)
			if xo == "X"
				puts "(X) #{player_x.name} is the Winner!"
			else
				puts "(O) #{player_o.name} is the Winner!"
			end
		end

		def run_game
			moves = 0
			loop do
				if board_state.winner?
					display_win_message("X")
					break
				else
					selection_x = make_move("X")
					board_state.write_board(selection_x, "X")
					moves += 1
				end
				if board_state.winner? || draw?(moves)
					board_state.winner? ? display_win_message("X") : declare_draw_message
					break
				else
					player_o.computer == true ? selection_o = make_move("O", computer = true) : selection_o = make_move("O")
					board_state.write_board(selection_o, "O")
					moves += 1
				end 
			end
		end

		def make_move(xo, computer = false)
			if  computer == true
				  computer_move(xo)
			else
				puts "Select a number to place an #{xo} in."
				entry = gets.chomp.to_i
				if entry.to_s =~ (/[1-9]/) && entry.to_s.length == 1 && board_state.spot_empty?(entry)
					entry
				else
					puts "Invalid entry.  Please enter a number between 1 - 9. On an Empty Square."
					make_move(xo)
				end
			end
		end

		def computer_move(xo)
			puts_thinking
			loop do
				choice = rand(1..9)
				if board_state.spot_empty?(choice)
					return choice
				end
			end
		end

		def puts_thinking
			puts "Thinking..."
			sleep(1.5)
		end	
	end

	class Game
		attr_reader :player1, :player2
		attr_accessor :board, :current_game
		def initialize
			@player1 = Player1.new
			@player2 = Player2.new
			@board = Board.new			
			@current_game = Engine.new(@player1, @player2, @board)
			puts_player_info
			begin_match
		end	

		def begin_match
			current_game.run_game
		end

		def puts_player_info
			puts "#{@player1.name} as (#{@player1.x_or_o})"
			puts "vs".rjust(6)
			puts "#{@player2.name} as (#{@player2.x_or_o})"
			puts ""
		end
	end

#Creates new game board and keeps track of its states.
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
		  puts ""         
	   	puts "|#{@board_state[1]}|#{@board_state[2]}|#{@board_state[3]}|"
		  puts "|#{@board_state[4]}|#{@board_state[5]}|#{@board_state[6]}|"
		  puts "|#{@board_state[7]}|#{@board_state[8]}|#{@board_state[9]}|"
		  puts ""
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
	end

#Gets name of Player 1 and asks if Player 1 wants to play as X or O.
	class Player1
		@@choice_container = {}
		attr_reader :computer
		attr_accessor :name, :x_or_o, :choice_container
		def initialize(computer = false, name = nil, x_or_o = nil)
			@computer = computer
			@name = name == nil ? get_name : name
			@x_or_o = x_or_o == nil ? get_x_or_o : x_or_o
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
			if @@choice_container == {}
				print "Would you like to play as X or O?: "
				choice = gets.chomp.capitalize
				if choice =~ (/[^XO]/)
					puts "Invalid Selection.  Please Type Either X or The Letter O"
					get_x_or_o
				else
					@@choice_container = {:player1 => choice}
					choice
				end
			else
				@@choice_container[:player1] == "X" ? "O" : "X"
			end
		end
	end

#Gets name of Player 2.
	class Player2 < Player1
	end

#Assigns players as X or O, and runs game logic while game is active.

	class HumanHumanGame < Game
	end

	class HumanCompEasyGame < Game
		def initialize
			@player1 = Player1.new
			@player2 = Player2.new(computer = true)
			@board = Board.new			
			@current_game = Engine.new(@player1, @player2, @board)
			puts_player_info
			begin_match
		end
	end
end
