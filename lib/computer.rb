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

  def create_computer_turn
    sleep(1)
    puts "Computer firing their missile..."
    sleep(2)
    computer_takes_shot
  end

  def computer_takes_shot
    computer_shot_coordinate = @user.user_board.cells.key.smaple

    until @user.user_board.valid_coordinate?(computer_shot_coordinate) && !@user.user_board.cells[computer_shot_coordinate].fired_upon?
      computer_shot_coordinate = @user.user_board.cells.keys.sample
    end
    computer_shot_feedback(computer_shot_coordinate)
  end

  def user_shot_feedback(computer_shot_coordinate)
    require "pry"; binding.pry
    @user.user_board.cells[computer_shot_coordinate].fire_upon
    if @user.user_board.cells[computer_shot_coordinate].render == "M"
      result = "miss"
    elsif @user.user_board.cells[computer_shot_coordinate].render == "H"
      result = "hit!"
    elsif @user.user_board.cells[computer_shot_coordinate].render == "X"
      result = "hit and sunk my #{@user.user_board.cells[computer_shot_coordinate].ship.name}!"
    end
    puts "\n Your shot on #{computer_shot_coordinate} was a #{result}\n\n"
    @user.all_user_ships_sunk
  end

  def all_computer_ships_sunk
    if computer_ships.all?(&:sunk?)
      sleep(2)
      puts "You win!\n\n"
      start_game
    else
      create_computer_turn
    end
  end
end
