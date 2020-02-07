require_relative 'board'
require_relative 'ship'

class User
  attr_reader :user_board, :user_ships

  def initialize
    @user_board = nil
    @user_ships = []
  end

  def create_user_board
    @user_board = Board.new
    @user_board.add_cells
    create_user_ships
  end

  def create_user_ships
    user_cruiser = Ship.new("Cruiser", 3)
    user_submarine = Ship.new("Submarine", 2)
    @user_ships << user_cruiser
    @user_ships << user_submarine
  end

  def place_user_ships(ship, user_coordinates)
    @user_board.place(ship, user_coordinates)
  end
end
