require_relative './computer'
require_relative './user'
require './lib/modules/playable'

class Game
  include Playable
  attr_accessor :computer, :user

  def initialize
    @computer = nil
    @user = nil
  end

  def welcome
    puts "Welcome to BATTLESHIP \n\n"
    sleep(1)

    start_game
  end

  def start_game
    puts "Enter p to play. Enter q to quit."
    print "> "
    main_menu_input = gets.chomp.downcase

    until main_menu_input["p"] || main_menu_input["q"]
      puts " \nPlease enter a valid selection"
      print "> "
      main_menu_input = gets.chomp.downcase
    end
    main_menu_input == "p" ? players_setup : return
  end

  def players_setup
    @computer = Computer.new
    @computer.setup_computer

    @user = User.new
    @user.setup_user

    print "The game is setup. Let's begin. You go first.\n\n\n"
    sleep(0.5)

    user_shot_input
  end

  def user_shot_input
    render_boards

    puts "\n\nEnter the coordinate for your shot:"
    print "> "
    user_shot_coordinate = gets.chomp.upcase

    user_shot_validation(user_shot_coordinate, @computer.computer_board)
  end

  def user_shot_validation(user_shot_coordinate, computer_board)
    valid_coordinate = computer_board.valid_coordinate?(user_shot_coordinate)
    not_fired_upon = !@computer.computer_board.cells[user_shot_coordinate].fired_upon?

    until valid_coordinate && not_fired_upon
      if !computer_board.valid_coordinate?(user_shot_coordinate)
        puts "You entered an invalid coordinate!"
      elsif computer_board.cells[user_shot_coordinate].fired_upon?
        puts "You already fired upon this cell."
      end
      user_shot_input
    end

    sleep(1)
    puts "\nFiring your missle..."
    sleep(2)

    @user.user_shot_feedback(user_shot_coordinate, @computer.computer_board)
    all_computer_ships_sunk
  end

  def all_user_ships_sunk
    if @user.user_ships.all?(&:sunk?)
      sleep(1)
      puts "YOU LOSE!\n\n"
      puts "Would you like to play again?\n\n"
      restart_game
    else
      user_shot_input
    end
  end

  def all_computer_ships_sunk
    if @computer.computer_ships.all?(&:sunk?)
      sleep(2)
      puts "YOU WIN!\n\n"
      puts "Would you like to play again?\n\n"
      restart_game
    else
      @computer.create_computer_turn(@user.user_board)
      all_user_ships_sunk
    end
  end

  def restart_game
    sleep(1)
    start_game
  end
end
