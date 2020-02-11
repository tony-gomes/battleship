require_relative './ship'
require_relative './board'

class Computer
  attr_reader :computer_board, :computer_ships

  def initialize
    @computer_board = nil
    @computer_ships = []
  end

  def setup_computer
    sleep(0.5)
    puts "\n\n...game loading...\n\n"
    sleep(2)
    puts "Computer is placing ships on their grid...\n\n"
    create_computer_board
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

  def create_computer_turn(user_board)
    sleep(1)
    puts "Computer firing their missile..."
    sleep(2)
    computer_takes_shot(user_board)
  end

  def computer_takes_shot(user_board)
    computer_shot_coordinate = user_board.cells.keys.sample
    until user_board.valid_coordinate?(computer_shot_coordinate) && !user_board.cells[computer_shot_coordinate].fired_upon?
      computer_shot_coordinate = user_board.cells.keys.sample
    end
    computer_shot_feedback(computer_shot_coordinate, user_board)
  end

  def computer_shot_feedback(computer_shot_coordinate, user_board)
    user_board.cells[computer_shot_coordinate].fire_upon
    if user_board.cells[computer_shot_coordinate].render == "M"
      result = "miss"
    elsif user_board.cells[computer_shot_coordinate].render == "H"
      result = "hit!"
    elsif user_board.cells[computer_shot_coordinate].render == "X"
      result = "hit and sunk your #{user_board.cells[computer_shot_coordinate].ship.name}!"
    end
    puts "\nComputer's shot on #{computer_shot_coordinate} was a #{result}\n\n"
  end
end
