class Player
	attr_accessor :name, :role, :code, :guess

	def initialize(name, role)
		@name = name
		@role = role
		@guess = []
		@code = []
	end

	def make_code
		puts "#{@name}, choose 4 among the following colors: "
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

	def guess_code(feedback_arr)
		puts "#{@name}, choose 4 among the following colors:"
    puts "\n"
    puts "Blue, Red, Green, Yellow, Purple, Brown"
    puts "\n"
		puts "Press 'enter' after each color."
		puts "Remember that you can enter multiples of each color."
    i = 0
    while i < 4
      input = gets.chomp.capitalize
      @guess[i] = input
      i += 1
		end
	end
end

class AI
	attr_accessor :role, :code, :guess

	def initialize(role)
		@role = role
		@guess = []
	end

  def make_code
    puts "\n"
    puts "Puny human! You will never solve my code!"  
    puts "--Some AI probably"
		@code = []
		colors = ["Blue", "Red", "Green", "Yellow", "Purple", "Brown"]
		4.times do
			@code << colors.sample
		end
	end

	def guess_code(feedback_arr)
		colors = ["Blue", "Red", "Green", "Yellow", "Purple", "Brown"]
	  forbidden_index = []
		if feedback_arr.all? nil
			4.times do
				@guess << colors.sample
			end
		else
			feedback_arr.each_with_index do |color, index|
				if color == @guess[index]
					@guess[index] = color
					forbidden_index << index
				end
			end
      puts "forbidden_index is #{forbidden_index}"
      i = 0
      new_index = []
      while i < 4
        indices = [0, 1, 2, 3]
        if forbidden_index.include?(i) || new_index.include?(i)
          i += 1
        elsif feedback_arr[i] == "White"
          indices = indices - forbidden_index - [i] - new_index
          new_index << indices.sample
          hold = @guess[new_index[-1]]       
          @guess[new_index[-1]] = @guess[i]
          @guess[i] = hold
          i += 1
        else
          new_colors = colors - [@guess[i]]
          @guess[i] = new_colors.sample
          i += 1
			  end
			end
		end
	end
end

class Mastermind
	attr_reader :feedback_arr, :turns
	
	def initialize
		@turns = 0
		@feedback_arr = Array.new(4)
	end

	def startup
		puts "Welcome to Mastermind! In this game, you will either be a codemaker or a codebreaker."
		puts "A codemaker will determine a secret code that the AI will attempt to solve."
		puts "A codebreaker will attempt to decipher the wily AI's secret."
		puts "You have 12 turns."
		puts "What is your name?"
		player_name = gets.chomp.capitalize
		puts "\n"
		puts "Great! Welcome #{player_name}!"
		puts "Would you like to play as the codemaker or the codebreaker?"
		player_role = gets.chomp.downcase
		if player_role != "codemaker" && player_role != "codebreaker"
			puts "Please choose either: 'codemaker' or 'codebreaker'"
			player_role = gets.chomp.downcase
		end
		puts "So, #{player_name}, you will be playing as the mighty #{player_role}."
		if player_role == "codemaker"
			ai_role = "codebreaker"
		else
			ai_role = "codemaker"
		end
		puts "That means the AI will be the #{ai_role}."
		@player = Player.new(player_name, player_role)
		@AI = AI.new(ai_role)
		if @player.role == "codemaker"
			@maker = @player
		else
			@maker = @AI
		end
		if @maker == @player
			@breaker = @AI
		else
			@breaker = @player
		end
		@maker.make_code
	end

	def feedback
		@code = @maker.code
		puts "\n"
		@guess = @breaker.guess
		forbidden_index = []
    max_whites = {}
    @code.each do |color| 
      if @code.count(color) == 1
        max_whites[color] = 1
      elsif @code.count(color) == 2
        max_whites[color] = 2
      elsif @code.count(color) == 3
        max_whites[color] = 1
      else
        max_whites[color] = 0
      end
    end
    
    @code.each_with_index do |color, index|
      if color == @guess[index]
        @feedback_arr[index] = color
        max_whites[color] -= 1
        forbidden_index << index
      end
    end
    i = 0
    while i < 4
      if forbidden_index.include?(i)
        i += 1
      elsif max_whites[@guess[i]].to_i >= 1
        @feedback_arr[i] = "White"
        max_whites[@guess[i]] -= 1
        i += 1
      else
        @feedback_arr[i] = "Incorrect"
        i += 1
      end
    end
		puts "\n"
		@turns += 1
		puts "\n"
		puts "Feedback from Turn ##{@turns}"
		puts "---------------------------------"
		print "#1: #{@feedback_arr[0]} #2: #{@feedback_arr[1]} #3: #{@feedback_arr[2]} #4: #{@feedback_arr[3]}"
		puts "\n"
		puts "---------------------------------"
		puts "\n"
	end

	def victory?
		victory = false
		if @code == @feedback_arr && @player.role == "codebreaker"
			puts "Congratulations #{@player.name}! You defeated the AI in #{@turns} turns."
			victory = true
		elsif @code == @feedback_arr
			puts "Return of Ganon."
			puts "The AI read you like a book."
			puts "It only took it #{@turns} turns."
			victory = true
		end
	end

	def main_loop
		startup
		until victory? || @turns > 11
			if @turns > 0
				puts "\n"
				puts "The previous guess was: "
				puts "---------------------------------"
				puts "#1: #{@guess[0]} #2: #{@guess[1]} #3: #{@guess[2]} #4: #{@guess[3]}"
				puts "---------------------------------"
				puts "\n"
			end
			@breaker.guess_code(@feedback_arr)
			feedback
		end
		if @turns == 12 && !victory?
			if @maker == @player 
				puts "You triumphed this day, but at what cost?"
        puts "Your hidden code was: "
			else
				puts "Return of Ganon."
				puts "You couldn't outsmart even this AI."
				puts "The hidden code was: "
			end
		print @code
		puts "\n"
		end
	end
end

game = Mastermind.new
game.main_loop