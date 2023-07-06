class Board
  attr_reader :state
  attr_accessor :empty_cells

  def initialize(board)
    @state = board
    @empty_cells = 9
  end

  def self.create_board()
    board = Array.new(3) { Array.new(3) { "" } }
    Board.new(board)
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
      result.append("#{row_names[row]}#{cell_number}") if cell.empty?
      result
    end
  end
 
end


class Player
  attr_accessor :name, :marker, :wins

  def initialize(name, marker)
    @name = name
    @marker = marker
    @wins = 0
  end

end


class Game
  def initialize(player1_name, player2_name)
    @board = Board.create_board
    @player1 = Player.new(player1_name, 'X')
    @player2 = Player.new(player2_name, 'O')
    @turn = @player1
    @first_turn = @player1
    @second_turn = @player2
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
      round_end = false
      player_move = get_player_move(@turn, @board.open_cells)

      update_board(@turn, player_move)
      display_board()
  
      game_end = end_game?
    end
  end


  def display_board()
    @board.state.each do |row|
      puts row.map { |cell| cell.empty? ? '   ' : " #{cell} " }.join('|')
      puts '-' * (row.length * 4 - 1) unless row.object_id == @board.state.last.object_id
    end
  end


  def get_player_move(player, available_moves)
    move = ""
    until available_moves.include?(move.upcase)
      puts "#{player.name} - Please enter a valid cell from #{available_moves.join(", ")}"
      move = gets.chomp()
    end
    move
  end


  def update_board(player, player_move)
    row, column = convert_move_to_index(player_move)
    @board.update_cell(player.marker, row, column)
    @board.empty_cells -= 1
  end


  def convert_move_to_index(player_move)
    case player_move[0]
    when 'A' then return 0, player_move[1].to_i - 1
    when 'B' then return 1, player_move[1].to_i - 1
    when 'C' then return 2, player_move[1].to_i - 1
    end
  end


  def win?(player)
    opposite_marker = player.marker == 'X' ? 'O' : 'X'
    board = @board.state
    
    # Check for row win
    board.each { |row| return true if three_in_a_row?(row, opposite_marker) }

    # Check for column win
    board.transpose.each { |row| return true if three_in_a_row?(row, opposite_marker) }

    # Check for cross win
    return true if three_in_a_row?([board[0][0], board[1][1], board[2][2]], opposite_marker)
    return true if three_in_a_row?([board[0][2], board[1][1], board[2][0]], opposite_marker)

    false
  end

  def three_in_a_row?(line, opposite_marker)
    (line.include?('') || line.include?(opposite_marker)) ? false : true
  end


  def end_game?()
    won = win?(@turn)
    @turn.wins += 1 if won
    tie = (@board.empty_cells == 0) unless won
    
    unless won || tie
      @turn = @turn == @player1 ? @player2 : @player1 unless won || tie
      return false
    end

    # Round over since there was a win or tie
    puts "#{@turn.name} wins!\nThe score is now:\n#{@player1.name}: #{@player1.wins}\n#{@player2.name}: #{@player2.wins}" if won
    puts "Round tie!" if tie
    
    @turn, @first_turn, @second_turn = @second_turn, @second_turn, @first_turn
    @board = Board.create_board

    return play_again? ? false : true
  end

  def play_again?()
    puts "Play again? Yes/No"
    return gets.chomp().downcase == 'yes' ? true : false
  end
end

Game.initialize_game()