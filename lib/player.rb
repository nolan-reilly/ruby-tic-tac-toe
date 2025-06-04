# Represents a player in a tic, tac, toe game
class Player
  attr_accessor :is_turn, :has_won
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @is_turn = false
    @has_won = false
  end
end
