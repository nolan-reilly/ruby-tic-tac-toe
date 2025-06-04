require_relative './board'
require_relative './player'

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
    while !@player_one.has_won || !@player_two.has_won
      # Game Loop
      write_to_cell(@player_one.symbol) if @player_one.is_turn
      write_to_cell(@player_two.symbol) if @player_two.is_turn
      swap_turns

    end
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
    row = prompt_coordinate('row')
    col = prompt_coordinate('col')

    @board.write_to_cell(row, col, symbol)
    @board.print_board
  end

  def prompt_coordinate(type)
    loop do
      puts "Select a #{type} [0-2]: "
      input = gets.chomp.to_i
      return input if input >= 0 || input < 4

      puts "Please Enter a Valid #{type}"
    end
  end
end

game_controller = GameController.new
game_controller.game_loop
