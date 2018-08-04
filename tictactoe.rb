class Game 

    attr_reader :player_one, :player_two
  
  
    @@board = [["  ", "A", "   ", "B", "   ", "C", " "],["  ", " ", "   ", " ", "   ", " ", " "],
            ["1 ", " ", " | ", " ", " | ", " ", " "],[" -", "-", "-|-", "-", "-|-", "-", "-"],
            ["2 ", " ", " | ", " ", " | ", " ", " "],[" -", "-", "-|-", "-", "-|-", "-", "-"],
            ["3 ", " ", " | ", " ", " | ", " ", " "]]
    
    @@win_cond = [ ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", ""], ["", "", "",], ["", "", ""] ]
    

    def initialize(player_one, player_two)
      @player_one = player_one
      @player_two = player_two
    end
    
    def main_loop
      draw_board
      until victory?
        current = @player_one
        make_play(current)
        if victory? != true
            current = @player_two
            make_play(current)
        end
      end
      puts "Congratulations! #{current.name} wins!"
    end
  
    def showwin
        @@win_cond.each {|x| puts x}
    end


    def draw_board
      @@board.each do |column|
        puts "\n"
        column.each do |char|
          print char
        end
      end
      puts "\n"
    end
  
    def clear_board
      @@board.each do |column|
        column.each do |char|
          char.gsub!(/[XO]/, " ")
        end
      end
    end
  
    def victory?
      victory = false
      @@win_cond.each do |cond|
          if cond.all? /X/ 
            victory = true
            break
          elsif cond.all? /O/
            victory = true
            break
          else
            victory = false
          end
      end
      victory
    end
  
    def board_set(player)
      name = player.name
      piece = player.piece
      pos = gets.chomp.capitalize
      case pos 
        when "A1"
          @@board[2][1] = piece
        else
          puts "This test failed for some reason."
      end
      draw_board
    end
  
    def make_play(player)
      name = player.name
      piece = player.piece
      puts "#{name}, where would you like to place your piece?"
      pos = gets.chomp.capitalize
      case pos
=begin
  0  a1 a2 a3
  1  b1 b2 b3
  2  c1 c2 C3
  3  a1 b1 c1
  4  a2 b2 c2
  5  a3 b3 C3
  6  a1 b2 C3
  7  c1 b2 a3
=end
        when "A1"
          @@board[2][1] = piece
          @@win_cond[0][0] = piece 
          @@win_cond[3][0] = piece 
          @@win_cond[6][0] = piece
        when "A2"
          @@board[4][1] = piece
          @@win_cond[0][1] = piece
          @@win_cond[4][0] = piece
        when "A3"
          @@board[6][1] = piece
          @@win_cond[0][2] = piece
          @@win_cond[5][0] = piece 
          @@win_cond[7][0] = piece
        when "B1"
          @@board[2][3] = piece
          @@win_cond[1][0] = piece
          @@win_cond[3][1] = piece
        when "B2"
          @@board[4][3] = piece
          @@win_cond[1][1] = piece
          @@win_cond[4][1] = piece
          @@win_cond[6][1] = piece
          @@win_cond[7][1] = piece
        when "B3"
          @@board[6][3] = piece
          @@win_cond[1][2] = piece
          @@win_cond[5][1] = piece
        when "C1"
          @@board[2][5] = piece
          @@win_cond[2][0] = piece
          @@win_cond[3][2] = piece
          @@win_cond[7][2] = piece
        when "C2"
          @@board[4][5] = piece
          @@win_cond[2][1] = piece 
          @@win_cond[4][2] = piece
        when "C3"
          @@board[6][5] = piece
          @@win_cond[2][2] = piece
          @@win_cond[5][2] = piece
          @@win_cond[6][2] = piece
      end
      draw_board

   end
  
  end
  
  class Player
    
    attr_accessor :name, :piece
  
    def initialize(name, piece)
      @name = name
      @piece = piece
    end
  
  end
  
  player1 = Player.new("Player 1", "X")
  player2 = Player.new("Player 2", "O")
  new_game = Game.new(player1, player2)
  new_game.main_loop