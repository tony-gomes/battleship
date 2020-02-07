require_relative 'test_helper'
require './lib/computer'

class ComputerTest < MiniTest::Test
  def setup
    @computer = Computer.new
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_it_can_create_computer_boards
    @computer.create_computer_board
    assert_instance_of Board, @computer.computer_board
    refute @computer.computer_board.cells.empty?
  end

  def test_it_can_create_computer_ships
    @computer.create_computer_ships

    assert_instance_of Ship, @computer.computer_ships[0]
    assert_instance_of Ship, @computer.computer_ships[-1]
  end

  def test_it_can_place_computer_ships
    @computer.create_computer_board
    @computer.create_computer_ships
    @computer.place_computer_ships

    assert_instance_of Array, @computer.computer_ships
    refute @computer.computer_ships.empty?
    assert_equal 2, @computer.computer_ships.size
  end
end
