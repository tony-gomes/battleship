require_relative 'computer'
require_relative 'user'

class Game
  attr_accessor :computer, :user

  def initialize
    @computer = nil
    @user = nil
  end

  def welcome
    puts "Welcome to BATTLESHIP \n\n"
    sleep(2)
    start_game
  end

  def start_game
    puts "Enter p to play. Enter q to quit. \n\n"
    print "> "
    menu_selection = gets.chomp.downcase

    # until menu_selection.match(/"p"|"q"/)
    until menu_selection == "p" || menu_selection == "q"
      puts "\nPlease enter a valid selection"
      print "> "
      menu_selection = gets.chomp.downcase
    end

    menu_selection == "p" ? computer_setup : return
  end

  def computer_setup
    sleep(0.5)
    puts "\n\n...game loading...\n\n"
    sleep(2)
    puts "Computer is placing ships on their grid...\n\n"
    sleep(2)

    @computer = Computer.new
    @computer.create_computer_board
    user_setup
  end

  def user_setup
    puts "The computer's ships are on the grid.\n\n"
    sleep(2)
    puts "Now it's your turn.\n\n"
    sleep(2)

    @user = User.new
    @user.create_user_board

    puts "Ships require coordinates to place them on the board:\n"
    puts "For example:\n\nA1 A2 A3\nor\nA1 B1 C1\n\n"
    sleep(2)
    print "Press Return To Continue\n\n\n"
    _user_instructions_pause = gets.chomp
    user_ship_coordinates
  end

  def user_ship_coordinates
    @user.user_ships.each do |ship|
      puts @user.user_board.render(true)
      puts "\nEnter #{ship.length} coordinates for your #{ship.name}:"
      print "> "
      user_coordinates = gets.chomp.upcase.split
      puts "\n\n\n"

      until @user.user_board.valid_placement?(ship, user_coordinates)
        puts "\nThose are invalid coordinates. Please try again:"
        print "> "
        user_coordinates = gets.chomp.upcase.split
      end
      @user.place_user_ships(ship, user_coordinates)
    end
    user_shot_input
  end

  def render_boards
    sleep(1.5)
    puts "\n==========CURRENT COMPUTER BOARD=========="
    puts @computer.computer_board.render
    puts "\n===========CURRENT USER BOARD==========="
    puts @user.user_board.render(true)
  end

  def user_shot_input
    render_boards
    sleep(1)
    puts "\nEnter the coordinate for your shot:"
    print "> "

    user_shot_coordinate = gets.chomp.upcase
    user_shot_validation(user_shot_coordinate)
  end

  def user_shot_validation(user_shot_coordinate)
    until @computer.computer_board.valid_coordinate?(user_shot_coordinate) && !@computer.computer_board.cells[user_shot_coordinate].fired_upon?

      if !@computer.computer_board.valid_coordinate?(user_shot_coordinate)
        puts "\nYou have entered an invalid coordinate."
      elsif @computer.computer_board.cells[user_shot_coordinate].fired_upon?
        puts "\nYou have already fired upon this cell."
      end
      user_shot_input
    end
    sleep(1)
    puts "\nFiring your missile..."
    sleep(2)
    user_shot_feedback(user_shot_coordinate)
  end

  def user_shot_feedback(user_shot_coordinate)
    @computer.computer_board.cells[user_shot_coordinate].fire_upon
    if @computer.computer_board.cells[user_shot_coordinate].render == "M"
      result = "miss."
    elsif @computer.computer_board.cells[user_shot_coordinate].render == "H"
      result = "hit!"
    elsif @computer.computer_board.cells[user_shot_coordinate].render == "X"
      result = "hit and sunk my #{@computer.computer_board.cells[user_shot_coordinate].ship.name}!"
    end

    puts "\nYour shot on #{user_shot_coordinate} was a #{result}\n\n"

    all_computer_ships_sunk
  end

  def all_computer_ships_sunk
    if @computer.computer_ships.all?(&:sunk?)
      sleep(2)
      puts "You win!\n\n"
      puts "Would you like to play again?\n\n"
      start_game
    else
      create_computer_turn
    end
  end

  def create_computer_turn
    sleep(1)
    puts "Firing my missile..."
    sleep(2)
    computer_takes_shot
  end

  def computer_takes_shot
    computer_shot_coordinate = @user.user_board.cells.keys.sample

    until @user.user_board.valid_coordinate?(computer_shot_coordinate) && !@user.user_board.cells[computer_shot_coordinate].fired_upon?
      computer_shot_coordinate = @user.user_board.cells.keys.sample
    end
    computer_shot_feedback(computer_shot_coordinate)
  end

  def computer_shot_feedback(computer_shot_coordinate)
    @user.user_board.cells[computer_shot_coordinate].fire_upon

    if @user.user_board.cells[computer_shot_coordinate].render == "M"
      result = "miss."
    elsif @user.user_board.cells[computer_shot_coordinate].render == "H"
      result = "hit!"
    elsif @user.user_board.cells[computer_shot_coordinate].render == "X"
      result = "hit and sunk your #{@user.user_board.cells[computer_shot_coordinate].ship.name}!"
    end

    puts "\nMy shot on #{computer_shot_coordinate} was a #{result}\n\n"
    all_user_ships_sunk
  end

  def all_user_ships_sunk
    if @user.user_ships.all?(&:sunk?)
      sleep(1)
      puts "You lose!\n\n"
      puts "Would you like to play again?\n\n"
      start_game
    else
      user_shot_input
    end
  end

  def end_game
    puts "\nGoodbye.\n\n"
  end
end
