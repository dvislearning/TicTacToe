require 'stringio'


class Player
	attr_accessor :name, :mark, :computer
	def initialize(name, mark, computer = false)
		@name = name
		@mark = mark
		@computer = computer
	end
end
