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