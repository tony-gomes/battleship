require './lib/ship'
require './lib/board'
require './lib/game'
require './lib/computer'
require './lib/modules/playable'

class User
  attr_reader :user_board, :user_ships

  def initialize
    @user_board = nil
    @user_ships = []
  end

  def create_user_board(board_size)
    puts "The computer's ships are on the grid.\n\n"
    sleep(2)

    puts "Now it's your turn.\n\n"
    sleep(2)

    @user_board = Board.new
    @user_board.add_cells(board_size)

    create_user_ships
  end

  def create_user_ships
    user_cruiser = Ship.new("Cruiser", 3)
    user_ships << user_cruiser

    user_submarine = Ship.new("Submaine", 2)
    user_ships << user_submarine

    get_user_coordinates
  end

  def get_user_coordinates
    puts "Ships require coordinates to place them on the board.\n"
    puts "\n\nFor example:\n\nA1 A2 A3 or B1 C1\n\n"
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
        puts "Ships require coordinates to place them on the board:\n"
        puts "For example:\n\nA1 A2 A3 or B1 C1\n\n"
        print "> "
        user_coordinates_input = gets.chomp.upcase.split
      end
      place_user_ships(ship, user_coordinates_input)
    end
  end

  def place_user_ships(ship, user_coordinates)
    @user_board.place(ship, user_coordinates)
  end

  def user_shot_feedback(user_shot_coordinate, computer_board)
    computer_board.cells[user_shot_coordinate].fire_upon
    if computer_board.cells[user_shot_coordinate].render == "M"
      result = "miss"
    elsif computer_board.cells[user_shot_coordinate].render == "H"
      result = "hit!"
    elsif computer_board.cells[user_shot_coordinate].render == "X"
      result = "hit and sunk the Computer's #{computer_board.cells[user_shot_coordinate].ship.name}!"
    end
    puts "\nYour shot on #{user_shot_coordinate} was a #{result}\n\n"
  end
end
