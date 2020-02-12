require_relative '../board'

module Playable
  def render_boards
    sleep(1.5)
    puts "\n=============CURRENT COMPUTER BOARD============="
    puts @computer.computer_board.render
    puts "\n=============CURRENT USER BOARD================="
    puts @user.user_board.render(true)
  end
end
