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
    puts "\n\n\nWelcome to BATTLESHIP \n\n\n"
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

    main_menu_input == "p" ? get_board_size : return
  end

  def get_board_size
    puts "\n\n\nChoose board size: (Standard Board = 4)"
    puts "Please enter 4, 8, 12, or 16"
    board_size = gets.chomp

    until board_size['4'] || board_size['8'] || board_size['12'] || board_size['16']
      puts "\nInvalid Board Size: Please enter 4, 8, 12, or 16"
      board_size = gets.chomp
    end

    board_size = board_dimensions(board_size.to_i)
    players_setup(board_size)
  end

  def players_setup(board_size)
    @computer = Computer.new
    @computer.create_computer_board(board_size)

    @user = User.new
    @user.create_user_board(board_size)

    sleep(1.5)
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
