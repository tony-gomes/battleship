require_relative '../board'

module Playable
  def render_boards
    sleep(1.5)
    puts "\n=============COMPUTER BOARD============="
    puts @computer.computer_board.render
    puts "\n=============PLAYER BOARD================="
    puts @user.user_board.render(true)
  end
end
