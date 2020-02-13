require_relative './test_helper'
require './lib/computer'
require './lib/board'
require './lib/ship'
require './lib/cell'

class ComputerTest < Minitest::Test
  def setup
    @computer = Computer.new
    @user_board = Board.new
    @user_board.add_cells
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_it_starts_without_board_and_ships
    assert_nil @computer.computer_board
    assert_equal [], @computer.computer_ships
  end

  def test_it_can_create_a_computer_board_with_cells
    @computer.create_computer_board
    assert_instance_of Board, @computer.computer_board
    assert_equal 16, @computer.computer_board.cells.size
  end

  def test_it_creates_computer_ships
    @computer.create_computer_board
    assert_equal 2, @computer.computer_ships.size
    assert_instance_of Ship, @computer.computer_ships[0]
    assert_instance_of Ship, @computer.computer_ships[1]
    assert_equal 3, @computer.computer_ships[0].length
    assert_equal 2, @computer.computer_ships[1].length
  end

  def test_it_places_computer_ships
    skip
    @computer.create_computer_board
    require "pry"; binding.pry
    assert @computer.computer_board.cells.include?(cell.ship)
  end

  def test_it_can_create_computer_shot
    skip
    assert_instance_of String, @computer.computer_takes_shot(@user_board)
    assert @user_board.cells.keys.include?(@computer.computer_takes_shot(@user_board))
    refute @user_board.cells[@computer.computer_takes_shot(@user_board)].fired_upon?
  end
end
