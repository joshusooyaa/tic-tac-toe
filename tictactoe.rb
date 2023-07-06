class Board
  attr_reader :state

  def initialize
    @state = Array.new(3, Array.new(3))
  end

  # Update a cell with the player's marker
  #
  # @return [nil]
  def update_cell(marker, x_loc, y_loc)
    @state[x_loc][y_loc] = marker
  end
end


class Player
  attr_accessor :name, :player_marker, :score

  def initialize(name, player_marker)
    @name = name
    @player_marker = player_marker
    @wins = 0
  end
end


class Game
  def initialize(player1_name, player2_name)
    @board = Board.new()
    @player1 = Player.new(player1_name, 'x')
    @player2 = Player.new(player2_name, 'o')
    @turn = @player1
  end

  def self.start_game()
    puts "Welcome to Tic-Tac-Toe!\nPlease Enter Player1 Name: "
    player1_name = gets.chomp() 
    puts "Please Enter Player2 Name: "
    player2_name = gets.chomp() 
    Game.new(player1_name, player2_name)
  end
end

p Game.start_game()