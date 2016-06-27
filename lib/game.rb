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

@game_mode = nil
@player1 = Hash.new

def get_game_mode
	mode_selection = gets.chomp.to_s
	if mode_selection =~ /^[1-3]$/
		@game_mode = mode_selection
	else
		puts "Selection invalid.  Please enter either 1,2,3 or 4"
		get_game_mode
	end
end

def initialize_chosen_mode
	case @game_mode
	when "1"
		puts "1"
	when "2"
		puts "2"
	when "3"
		puts "3"
	end
end



puts_start_message
get_game_mode
initialize_chosen_mode
