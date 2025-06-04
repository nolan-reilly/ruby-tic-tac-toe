require_relative './cell'

# Represents a tic, tac, toe board being able to write to cells and reset
class Board
  attr_accessor :board
  attr_reader :height, :width

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

  def write_to_cell(row, col, symbol)
    @board[row][col].value = symbol
  end

  def print_board
    @height.times do |row|
      @width.times do |col|
        cell_value = @board[row][col].value

        print ' - ' if @board[row][col].value.nil?
        print " #{cell_value} "
      end
      puts
    end
  end

  def reset_board
    @board = []
    initialize_board
  end
end
