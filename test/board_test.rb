require_relative 'test_helper'
require './lib/board'
require './lib/ship'

class BoardTest < MiniTest::Test
  def setup
    @new_board = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def test_it_exists_with_cells
    assert_instance_of Board, @new_board
    assert_empty @new_board.cells
  end

  def test_it_can_add_cells
    @new_board.add_cells
    assert_instance_of Hash, @new_board.cells
    assert @new_board.cells.key?('A1')
    assert_instance_of Cell, @new_board.cells.fetch('A1')
    assert_equal 16, @new_board.cells.size
  end

  def test_it_validates_coordinates
    @new_board.add_cells
    assert @new_board.valid_coordinate?('A1')
    assert @new_board.valid_coordinate?('D4')
    refute @new_board.valid_coordinate?('A7')
    refute @new_board.valid_coordinate?('Z2')
    refute @new_board.valid_coordinate?('**')
  end

  def test_it_compares_coordinates_size_to_ship_size
    assert @new_board.valid_size?(@cruiser, ['A1', 'A2', 'A3'])
    refute @new_board.valid_size?(@cruiser, ['B1', 'C1'])
    assert @new_board.valid_size?(@submarine, ['B3', 'C3'])
    refute @new_board.valid_size?(@submarine, ['B1', 'C1', 'D1'])
  end

  def test_it_can_check_if_letters_same
    assert @new_board.letters_same?(['A1', 'A2', 'A3'])
    refute @new_board.letters_same?(['B3', 'C3'])
  end

  def test_it_can_check_if_numbers_same
    refute @new_board.numbers_same?(['B1', 'B2', 'B3'])
    assert @new_board.numbers_same?(['B1', 'C1'])
  end

  def test_it_can_check_if_letters_consecutive
    assert @new_board.letters_consecutive?(['B1', 'C1', 'D1'])
    refute @new_board.letters_consecutive?(['B1', 'B2'])
  end

  def test_it_can_check_if_numbers_consecutive
    refute @new_board.numbers_consecutive?(['B1', 'C1', 'D1'])
    assert @new_board.numbers_consecutive?(['B1', 'B2'])
  end

  def test_it_can_check_if_cells_empty
    @new_board.add_cells

    assert @new_board.cells_empty?(['A1', 'B1'])
  end

  def test_it_can_validate_placement
    @new_board.add_cells

    assert @new_board.valid_placement?(@cruiser, ['A1', 'A2', 'A3'])
    assert @new_board.valid_placement?(@cruiser, ['B1', 'C1', 'D1'])
    refute @new_board.valid_placement?(@cruiser, ['B1', 'B2', 'B5'])
    refute @new_board.valid_placement?(@cruiser, ['A1', 'A2', 'A3', 'A4'])
    refute @new_board.valid_placement?(@cruiser, ['B1', 'C2', 'D3'])
    refute @new_board.valid_placement?(@cruiser, ['C3', 'D3', 'E3'])
    refute @new_board.valid_placement?(@cruiser, ['B1', 'A1', 'C1'])
    refute @new_board.valid_placement?(@cruiser, ['A3', 'A2', 'A1'])

    assert @new_board.valid_placement?(@submarine, ['B1', 'B2'])
    assert @new_board.valid_placement?(@submarine, ['C1', 'D1'])
    refute @new_board.valid_placement?(@submarine, ['A1', 'A4'])
    refute @new_board.valid_placement?(@submarine, ['D1', 'D2', 'D3'])
    refute @new_board.valid_placement?(@submarine, ['B2', 'C3'])
    refute @new_board.valid_placement?(@submarine, ['D4', 'D5'])
    refute @new_board.valid_placement?(@submarine, ['B1', 'D1'])
    refute @new_board.valid_placement?(@submarine, ['B2', 'B1'])
    refute @new_board.valid_placement?(@submarine, ['A1', 'A1'])
  end

  def test_it_cannot_have_overlapping_ships
    @new_board.add_cells

    @new_board.place(@cruiser, ['A1', 'A2', 'A3'])

    assert @new_board.valid_placement?(@submarine, ['B1', 'B2'])
    refute @new_board.valid_placement?(@submarine, ['A1', 'A2'])
    assert @new_board.valid_placement?(@submarine, ['A4', 'B4'])
    refute @new_board.valid_placement?(@submarine, ['A2', 'B2'])
  end
end
