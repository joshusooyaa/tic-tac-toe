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

  # Get all open cells on the board (all valid moves)
  #
  # @return [Array]: An array containing all open cell values
  def open_cells()
    row_names = ['A', 'B', 'C']
    row = 0

    open_cells = @state.flatten.each_with_index.reduce([]) do |result, (cell, index)| 
      row += 1 if index >= 1 && index % 3 == 0
      cell_number = index % 3 + 1
      result.append("#{row_names[row]}#{cell_number}")
      result
    end
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
      player_move = get_player_move(@turn, @board.open_cells)
      break
    end
  end


  def display_board()
    @board.state.each do |row|
      puts row.map { |cell| cell.empty? ? ' ' : cell }.join(' | ')
      puts '-' * (row.length * 3) unless row.object_id == @board.state.last.object_id
    end
  end


  def get_player_move(player, available_moves)
    move = ""
    until available_moves.include?(move.upcase)
      puts "Please enter a valid cell from #{available_moves.join(", ")}!"
      move = gets.chomp()
    end
  end
end

Game.initialize_game()