class Player
	attr_accessor :name, :role

	def initialize(name, role)
		@name = name
		@role = role
	end
end

class Mastermind
		
	def initialize
		@player = make_player
		@code = []
		@guess = []
		@feedback_arr = []
		@turns = 0
	end
	
	def make_player
		puts "What is your name?"
		name = gets.chomp.capitalize
		puts "Do you wish to play as the codemaker or the codebreaker?"
		role = gets.chomp.downcase
		puts "\n"
		Player.new(name, role)
	end

	def make_code
		colors = ["Blue", "Red", "Green", "Yellow", "Purple", "Brown"]
		if @player.role == "codebreaker"	
			4.times do
				@code << colors.sample
			end
			print "\n"
		else
			puts "#{@player.name}, choose 4 among the following colors: "
			puts "\n"
			puts "Blue, Red, Green, Yellow, Purple, Brown"
			puts "\n"
			puts "Please note that any number of repeats are allowed."
			puts "Press 'enter' after each color."
			4.times do
				input = gets.chomp.capitalize
				@code << input
			end
		end 
	end
	# White does not yet work properly. White guesses are discarded.
	def guess_code
		if @player.role == "codebreaker"
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
		else
			colors = ["Blue", "Red", "Green", "Yellow", "Purple", "Brown"]
			temp_array = Array.new(4)
			indices = []
			if @turns == 0
				4.times do
					@guess << colors.sample
				end
			else

				#First pass will insert correct answers into temp_array as well as choose a new color for incorrect answers
				i = 0
				while i < 4
					case @feedback_arr[i]
					when @guess[i]
						temp_array[i] = @guess[i]
						i += 1
					when "Incorrect"
						temp_array[i] = colors.sample
						indices << i
						i += 1
					else
						i += 1
					end
				end
				#Second pass begins by pushing the indices of unassigned spaces in the temp_array to an array called indices
				temp_array.each_with_index {|item, ind| indices << ind if item == nil }
				#From indices, the index of the current item i is removed and saved in ind. Ind is used to generate a new random index for the 'White' guess to move to
				#Only "White" or "Incorrect" indices are valid
				
				i = 0
				random_index = i
				while i < 4
					case @feedback_arr[i] 
					when "White"
						#ind must not equal the current position or the position of the previous "White"
						ind = indices.select {|index| index != i && index != random_index}
						#TEST
						puts "Ind is equal to #{ind}."
						random_index = ind[rand(ind.length)]
						puts "Random index is equal to #{random_index}"
						if @feedback_arr[random_index] == "Incorrect"
							new_colors = colors.select {|x| x != @guess[i]}
							temp_array[i] = new_colors.sample
							temp_array[random_index] = @guess[i]
						else
							temp_array[i] = temp_array[random_index]							
							temp_array[random_index] = @guess[i]
						end
						i += 1
					else
						i += 1
					end
				end
				@guess = temp_array
			end
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
		puts "Your feedback from turn #{@turns}"
		puts "---------------------------------"
		print "#1: #{@feedback_arr[0]} #2: #{@feedback_arr[1]} #3: #{@feedback_arr[2]} #4: #{@feedback_arr[3]}"
		puts "\n" 
		puts "---------------------------------"
		puts "\n" 
	end

	def victory?
		victory = false
		if @code == @feedback_arr && @player.role == "codebreaker"
			puts "Congratulations #{@player.name}! You won in #{@turns} turns."
				victory = true
		elsif @code == @feedback_arr
			puts "Looks like the AI figured out your code in #{@turns} turns!"
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
				puts "Remember the previous guess was:"
				puts "#1: #{@guess[0]} #2: #{@guess[1]} #3: #{@guess[2]} #4: #{@guess[3]}"
				puts "\n"
			end
			guess_code
			feedback
		end
		if @turns == 12 && victory? != true
			if @player.role == "codemaker"
				puts "You defeated the AI!"
				puts "Your hidden code was: "
			else
				puts "You lose!"
				puts "The hidden code was: "
			end
			print @code
			puts "\n"
		end
	end
end

game = Mastermind.new
game.main_loop