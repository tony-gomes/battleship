require './lib/ship'
require './lib/board'
require './lib/game'
require './lib/computer'

class User
  attr_reader :user_board, :user_ships

  def initialize
    @user_board = nil
    @user_ships = []
  end

  def setup_user
    puts "The computer's ships are on the grid.\n\n"
    sleep(2)
    puts "Now it's your turn.\n\n"
    sleep(2)
    create_user_board
  end

  def create_user_board
    @user_board = Board.new
    @user_board.add_cells
    create_user_ships
  end

  def create_user_ships
    user_cruiser = Ship.new("Cruiser", 3)
    user_submarine = Ship.new("Submaine", 2)
    user_ships << user_cruiser
    user_ships << user_submarine
    get_user_coordinates
  end

  def get_user_coordinates
    puts "Ships require coordinates to place them on the board:\n"
    puts "For example:\n\n A1 A2 A3 or B1 C1\n\n"
    sleep(2)
    @user_ships.each do |ship|
      puts "Enter #{ship.length} coordinates for your #{ship.name}."
      puts "\n" + @user_board.render(true) + "\n"
      print "> "
      user_coordinates_input = gets.chomp.upcase.split
      puts "\n\n\n"

      until @user_board.valid_placement?(ship, user_coordinates_input)
        puts "\n" + @user_board.render(true) + "\n"
        puts "\nThose are invalid coordinates. Please try again:"
        print "> "
        user_coordinates_input = gets.chomp.upcase.split
      end
      place_user_ships(ship, user_coordinates_input)
    end
  end

  def place_user_ships(ship, user_coordinates)
    @user_board.place(ship, user_coordinates)
  end

  def user_shot_input
    puts "Enter the coordinate for your shot: "
    print "> "

    user_shot_coordinate = gets.chomp.upcase
    user_shot_validation(user_shot_coordinate)
  end

  def user_shot_validation(user_shot_coordinate)
    require "pry"; binding.pry

    until @computer.computer_board.valid_coordinate?(user_shot_coordinate) && !@computer.computer_board.celss[user_shot_coordinate].fired_upon?

      if !@computer.computer_board.valid_coordinate?(user_shot_coordinate)
        puts "You entered an invalid coordinate!"
      elsif @computer.computer_board.cells[user_shot_coordinate].fired_upon?
        puts "You already fired upon this cell."
      end
      user_shot_input
    end
    sleep(1)
    puts "\nFiring your missle..."
    sleep(2)
    user_shot_feedback(user_shot_coordinate)
  end

  def user_shot_feedback(user_shot_coordinate)
    require "pry"; binding.pry
    @computer.computer_board.cells[user_shot_coordinate].fire_upon
    if @computer.computer_board.cells[user_shot_coordinate].render == "M"
      result = "miss"
    elsif @computer.computer_board.cells[user_shot_coordinate].render == "H"
      result = "hit!"
    elsif @computer.computer_board.cells[user_shot_coordinate].render == "X"
      result = "hit and sunk my #{@computer.computer_board.cells[user_shot_coordinate].ship.name}!"
    end
    puts "\n Your shot on #{user_shot_coordinate} was a #{result}\n\n"
    @computer.all_computer_ships_sunk
  end

  def all_user_ships_sunk?
    if user_ships.all?(&:sunk?)
      sleep(1)
      puts "You lose!\n\n"
      puts "Would you like to play again?\n\n"
      start_game
    else
      user_shot_input
    end
  end
end
