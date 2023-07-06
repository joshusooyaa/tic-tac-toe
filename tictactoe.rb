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

  def initialize(name, player_marker, wins)
    @name = name
    @player_marker = player_marker
    @wins = 0
  end

  # Create a new player, either player 1 or player 2 (default if 1 not passed)
  # 
  # @return [Player]: A new Player
  def self.create_player(name, player_number)
    player_number == 1 ? Player.new(name, 'x', 0) : Player.new(name, 'o', 0)
  end
end

