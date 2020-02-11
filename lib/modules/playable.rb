require_relative '../board'

module Playable
  def render_boards
    sleep(1.5)
    puts "\n=============CURRENT COMPUTER BOARD============="
    puts @computer.battle_board.render
    puts "\n=============CURRENT USER BOARD================="
    puts @user.battle_board.render(true)
  end

  def all_ships_sunk
    if player_ships.all?(&:sunk?)
      sleep(1)
      puts "You lose!\n\n"
      puts "Would you like to play again?\n\n"
      start_game
    end
      player_shot
  end



  # def all_user_ships_sunk
  #   if @user_ships.all?(&:sunk?)
  #     sleep(1)
  #     puts "You lose!\n\n"
  #     puts "Would you like to play again?\n\n"
  #     start_game
  #   elsif @computer_ships.all?(&:sunk?)
  #     sleep(2)
  #     puts "You win!\n\n"
  #     start_game
  #   else
  #     player_turn
  #   end
  # end

end
