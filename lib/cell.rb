# Represents a cell in a tic, tac, toe board
class Cell
  attr_accessor :value

  # Initialize an empty cell to place into each tic, tac, toe cell
  def initialize
    @value = nil
  end
end
