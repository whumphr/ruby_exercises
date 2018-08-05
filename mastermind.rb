class Player
	attr_accessor :name

	def initialize(name)
		@name = name
	end
end

class Mastermind
		
	def initialize(player)
		@player = player
		@code = []
		@guess = []
		@feedback_arr = []
		@turns = 0
	end

	def make_code
		colors = ["Blue", "Red", "Green", "Yellow", "Purple", "Brown"]
		4.times do
			@code << colors.sample
		end
			print "\n" 
	end

	def guess_code
		puts "#{@player.name}, choose 4 among the following colors:"
		puts "\n"
		puts "Blue, Red, Green, Yellow, Purple, Brown"
		puts "\n"
		puts "You have " + (12 - @turns).to_s + " turns to guess the hidden code."
		puts "Press 'enter' after each color."
		i = 0
		while i < 4
			input = gets.chomp.capitalize
			@guess[i] = input
			i += 1
		end
	end

	def feedback
		i = 0
		while i < 4
			if @code[i] == @guess[i]
				@feedback_arr[i] = @guess[i]
				i += 1
			elsif @code[i] != @guess[i] && @code.include?(@guess[i])
				@feedback_arr[i] = "White"
				i += 1
			else
				@feedback_arr[i] = "Incorrect"
				i += 1
			end
		end
		i = 0
	
		while i < 4
			if @feedback_arr[i] == "White" &&  @guess.count(@guess[i]) > @code.count(@guess[i])
				@feedback_arr[i] = "Incorrect"
				i += 1
			else
				i += 1
			end
		end

		@turns += 1
		puts "\n"
		print "#1: #{@feedback_arr[0]} #2: #{@feedback_arr[1]} #3: #{@feedback_arr[2]} #4: #{@feedback_arr[3]}"
		puts "\n" 
	end

	def victory?
		victory = false
		if @code == @feedback_arr
			puts "Congratulations #{@player.name}! You won in #{@turns} turns."
				victory = true            
		end
	end

	def main_loop
		make_code
		puts "Welcome to Mastermind. In this game, you will be trying to guess a secret code of 4 colors."
		puts "Once you guess, if the color and position were correct, that color will be returned."
		puts "If the color was correct but not the position, 'White' will be returned."
		puts "Otherwise it will simply be 'Incorrect'." 
		puts "Please note that repeats such as 'Blue' 'Blue' 'Blue' 'Blue' are allowed."
		puts "\n"
		while victory? != true && @turns < 12
			if @turns > 0
				puts "\n"
				puts "Remember your previous guess was:"
				puts "#1: #{@guess[0]} #2: #{@guess[1]} #3: #{@guess[2]} #4: #{@guess[3]}"
				puts "\n"
			end
			guess_code
			feedback
		end
		if @turns == 12
			puts "You lose! The hidden code was: "
			print @code
			puts "\n"
		end
	end
end

me = Player.new("Will")
game = Mastermind.new(me)
game.main_loop