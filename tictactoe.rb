class Board
  attr_reader: state
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