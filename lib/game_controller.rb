require_relative './board'
require_relative './player'

# TODO: Fix up general structure & code of game controller class

# Handles all game logic and user input of tic, tac, toe
class GameController
  # User input function
  def initialize
    @board = Board.new(3, 3)
    @player_one = Player.new('Player One', 'X')
    @player_two = Player.new('Player Two', 'O')

    @player_one.is_turn = true
  end

  def game_loop
    # If either player has won release from game loop
    while !@player_one.has_won && !@player_two.has_won
      # Let the current active player write a cell
      write_to_cell(@player_one.symbol) if @player_one.is_turn
      write_to_cell(@player_two.symbol) if @player_two.is_turn

      has_won = check_for_win # After a player has written a cell check if they won
      board_filled = board_filled?

      if has_won
        puts "#{@player_one.name} Won!\nExiting Game..."
        exit
      elsif board_filled
        puts "Board filled\nExiting Game..."
        exit
      else
        swap_turns
      end
    end
  end

  def board_filled?
    3.times do |i|
      3.times do |j|
        return false if @board.get_cell_value(i, j).nil?
      end
    end

    true # If we didn't return false after checking all the indices must be filled
  end

  def current_symbol
    if @player_one.is_turn
      @player_one.symbol
    else
      @player_two.symbol
    end
  end

  # Check each possible way that someone can win
  def check_for_win
    return true if check_row_win
    return true if check_column_win
    return true if check_main_diagonal_win
    return true if check_anti_diagonal_win

    false
  end

  def check_row_win
    symbol = current_symbol

    3.times do |i|
      has_won = true # Assume player has won at the start of each check
      3.times do |j|
        has_won = false if @board.get_cell_value(i, j) != symbol
      end

      return true if has_won
    end

    false
  end

  def check_column_win
    symbol = current_symbol

    3.times do |i|
      has_won = true # Assume player has won at the start of each check
      3.times do |j|
        has_won = false if @board.get_cell_value(j, i) != symbol
      end

      return true if has_won
    end

    false
  end

  def check_main_diagonal_win
    symbol = current_symbol

    has_won = true

    # Left to bottom right
    3.times do |i|
      has_won = false if @board.get_cell_value(i, i) != symbol
    end

    has_won
  end

  def check_anti_diagonal_win
    symbol = current_symbol
    has_won = true

    j = 2
    # Left to bottom right
    3.times do |i|
      has_won = false if @board.get_cell_value(i, j) != symbol
      j -= 1
    end

    has_won
  end

  def swap_turns
    if @player_one.is_turn
      @player_one.is_turn = false
      @player_two.is_turn = true
    else
      @player_one.is_turn = true
      @player_two.is_turn = false
    end
  end

  def write_to_cell(symbol)
    loop do
      row = prompt_coordinate('row')
      col = prompt_coordinate('col')

      unless @board.get_cell_value(row, col).nil?
        puts 'Cell Occupied'
        @board.print_board
        next
      end

      @board.write_to_cell(row, col, symbol)
      @board.print_board
      break
    end
  end

  def prompt_coordinate(type)
    loop do
      puts "Select a #{type} [0-2]: "
      input = gets.chomp.to_i
      return input if input >= 0 && input < 3

      puts "Please Enter a Valid #{type}"
    end
  end
end