require_relative './computer'
require_relative './user'
require './lib/modules/playable'

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
    puts "Enter p to play. Enter q to quit."
    print "> "
    main_menu_input = gets.chomp.downcase

    until main_menu_input == "p" || main_menu_input == "q"
      puts " \nPlease enter a valid selection"
      print "> "
      main_menu_input = gets.chomp.downcase
    end
    main_menu_input == "p" ? players_setup : return
  end

  def players_setup
    @computer = Computer.new
    @user = User.new(@computer)
    @computer.add_user(@user)
    @user.setup_user
    game_interface
  end

  def game_interface
    sleep(1)
    @user.user_shot_input
    start_game
  end
end
