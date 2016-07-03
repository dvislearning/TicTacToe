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
end

def computer_move(xo)
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




puts_start_message
initialize_chosen_mode(get_game_mode)
set_x_and_o

puts @player_x.inspect
puts @player_o.inspect

