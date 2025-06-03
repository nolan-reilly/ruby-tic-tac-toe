require_relative './cell'

# Represents a tic, tac, toe board being able to write to cells and reset
class Board
  attr_accessor :board

  def initialize(height, width)
    @height = height
    @width = width
    @board = []

    build_board
  end

  def build_board
    @height.times do
      row = []
      @width.times do
        row.push(Cell.new)
      end

      @board.push(row)
    end
  end

  def reset_board
    @board = []
    initialize_board
  end
end
