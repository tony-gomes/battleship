require_relative 'board'
require_relative 'ship'

class Computer
  attr_reader :computer_board, :computer_ships

  def initialize
    @computer_board = nil
    @computer_ships = []
  end

  def create_computer_board
    @computer_board = Board.new
    @computer_board.add_cells
    create_computer_ships
  end

  def create_computer_ships
    computer_cruiser = Ship.new("Cruiser", 3)
    computer_submarine = Ship.new("Submarine", 2)
    @computer_ships << computer_cruiser
    @computer_ships << computer_submarine
    place_computer_ships
  end

  def place_computer_ships
    @computer_ships.each do |ship|
      random_coordinates = @computer_board.cells.keys.sample(ship.length)

      until @computer_board.valid_placement?(ship, random_coordinates)
        random_coordinates = @computer_board.cells.keys.sample(ship.length)
      end

      @computer_board.place(ship, random_coordinates)
    end
  end
end
