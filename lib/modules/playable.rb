require_relative '../board'

module Playable
  def render_boards
    sleep(1.5)
    puts "\n=============COMPUTER BOARD============="
    puts @computer.computer_board.render
    puts "\n=============PLAYER BOARD================="
    puts @user.user_board.render(true)
  end

  def board_dimensions(board_size = 4)
    if board_size == 4
      x_axis = 4
      y_axis = 'D'
    elsif board_size == 8
      x_axis = 8
      y_axis = 'H'
    elsif board_size == 12
      x_axis = 12
      y_axis = 'L'
    elsif board_size == 16
      x_axis = 16
      y_axis = 'P'
    end
    add_cells(x_axis, y_axis)
  end
end
