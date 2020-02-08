require_relative './computer'
require_relative './user'

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
    @computer.setup_computer
    @user = User.new
    @user.setup_user
    require "pry"; binding.pry
    game_interface
  end

  def render_boards
    sleep(1.5)
    puts "\n=============CURRENT COMPUTER BOARD============="
    puts @computer.computer_board.render
    puts "\n=============CURRENT USER BOARD================="
    puts @user.user_board.render(true)
  end

  def game_interface
    render_boards
    sleep(1)
    @user.user_shot_input
  end


end
