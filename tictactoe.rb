class Board
  attr_reader :state

  def initialize
    @state = Array.new(3) { Array.new(3) { "" } }
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
    @player1 = Player.new(player1_name, 'X')
    @player2 = Player.new(player2_name, 'O')
    @turn = @player1
  end

  def self.initialize_game()
    puts "Welcome to Tic-Tac-Toe!\nPlease Enter Player1 Name: "
    player1_name = gets.chomp() 
    puts "Please Enter Player2 Name: "
    player2_name = gets.chomp() 
    game = Game.new(player1_name, player2_name)
    game.send(:game_loop)
  end

  private
  def game_loop()
    game_end = false
    until game_end
      display_board()
      break
    end
  end

  private
  def display_board()
    @board.state.each do |row|
      puts row.map { |cell| cell.empty? ? ' ' : cell }.join(' | ')
      puts '-' * (row.length * 3) unless row.object_id == @board.state.last.object_id
    end
  end
end

Game.initialize_game()