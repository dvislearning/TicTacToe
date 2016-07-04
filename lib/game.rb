require_relative 'board'
require_relative 'player'

def puts_start_message
	start_message = 
	
	%Q(
	Welcome to Tic Tac Toe!
	Please Select An Option
	------------------------------
	1: Human vs Human\n
	2: Human vs Computer (Easy)\n
	3: Exit
	------------------------------\n)
	puts start_message
end

@players = []
@current_player = nil
@board = Board.new
@player_x = nil
@player_o = nil

def get_game_mode
	mode_selection = gets.chomp.to_s
	if mode_selection =~ /^[1-3]$/
		@game_mode = mode_selection
	else
		puts "Selection invalid.  Please enter either 1,2,3 or 4"
		get_game_mosde
	end
end

def get_name(computer = false)
	if computer == false
		puts "Please Enter Your Name: "
		gets.chomp
	else
		"CPU"
	end
end

def get_mark
	if @players.empty?
		puts "Would you like to play as X or O?"
		mark_choice = gets.chomp.capitalize
		if mark_choice =~ /^[X|O]$/ 
			mark_choice
		else
			puts "Invalid entry"
			get_mark
		end
	else
		return @players[0].mark == "X" ? "O" : "X"
	end
end

def make_human_player
	name = get_name
	mark = get_mark
	Player.new(name, mark, computer = false)
end

def make_cpu_player
	name = get_name(computer = true)
	mark = get_mark
	Player.new(name, mark, computer = true)
end

def start_two_human_game
	2.times {@players << make_human_player}
end

def easy_human_comp_game
	@players << make_human_player
	@players << make_cpu_player
end

def initialize_chosen_mode(game_choice)
	case game_choice
	when "1"
		start_two_human_game
	when "2"
		easy_human_comp_game
	when "3"
		exit
	end
end

def set_x_and_o
	@player_x = @players.find{ |player| player.mark == "X"}
	@player_o = @players.find{ |player| player.mark == "O"}
	@current_player = @player_x
end

def puts_match_up
	match_up = 

	%Q(
		(X) #{@player_x.name}\n
		    vs\n
		(O) #{@player_o.name}
		)

	puts match_up
end

def declare_draw
	puts "This contest is a DRAW!"
	exit
end

def declare_winner
	puts "(#{@current_player.mark}) #{@current_player.name} is the Winner!"
	exit
end

def computer_move
	puts_thinking
	choice = nil
	loop do
		choice = rand(1..9)
		break if @board.spot_empty?(choice)
	end
	@board.write_board(choice, @current_player.mark)
end

def human_move(mark)
	puts "Select number to place an #{mark} on"
	selection = gets.chomp.to_i
	if !selection.to_s.match(/^[1-9]$/)
		puts "Please enter a number between 1-9"
		human_move(mark)
	end
	if !@board.spot_empty?(selection)
		puts "Please select an empty square!"
		human_move(mark)
	end
	@board.write_board(selection, mark)
end

def puts_thinking
	puts "CPU is thinking..."
	sleep(1.5)
end	


puts_start_message
initialize_chosen_mode(get_game_mode)
set_x_and_o
puts_match_up
@board.display_board
loop do
	@current_player.computer == true ? computer_move : human_move(@current_player.mark)
	@board.display_board
	declare_winner if @board.winner?
	declare_draw if @board.draw?
	@current_player = @players.find{ |player| player != @current_player }
end 