require_relative './test_helper'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Board, @board
    assert_equal 0, @board.cells.length
  end

  def test_it_can_add_cells
    @board.add_cells
    assert_equal 16, @board.cells.size
    assert @board.cells.key?('A1')
    refute @board.cells.key?('A5')
  end

  def test_it_can_validate_coordinates
    @board.add_cells
    assert_equal true, @board.valid_coordinate?('A1')
    assert_equal true, @board.valid_coordinate?('D4')
    assert_equal false, @board.valid_coordinate?('A5')
    assert_equal false, @board.valid_coordinate?('E1')
    assert_equal false, @board.valid_coordinate?('A22')
  end

  def test_it_compares_coordinate_size_to_ship_size
    assert @board.valid_size?(@cruiser, ['A1', 'A2', 'A3'])
    refute @board.valid_size?(@cruiser, ['A1', 'A2'])
    refute @board.valid_size?(@cruiser, ['A1', 'A2', 'A3', 'A4'])

    assert @board.valid_size?(@submarine, ['A2', 'A3'])
    refute @board.valid_size?(@submarine, ['A2', 'A3', 'A4'])
    refute @board.valid_size?(@submarine, ['A1'])
  end

  def test_it_can_tell_if_letters_are_same
    assert @board.letters_same?(['A1', 'A2', 'A3'])
    refute @board.letters_same?(['A1', 'C1'])
  end

  def test_it_can_tell_if_numbers_are_same
    refute @board.numbers_same?(['A1', 'A2', 'A3'])
    assert @board.numbers_same?(['A1', 'C1'])
  end

  def test_it_can_check_letters_consecutive
    assert @board.letters_consecutive?(['A1', 'B1', 'C1'])
    refute @board.letters_consecutive?(['A1', 'A2', 'A3'])
  end

  def test_it_can_check_numbers_consecutive
    assert @board.numbers_consecutive?(['A1', 'A2', 'A3'])
    refute @board.numbers_consecutive?(['A1', 'B1', 'C1'])
  end

  def test_it_can_check_cells_empty
    @board.add_cells
    assert @board.cells_empty?(['A1', 'A2', 'A3'])

    @board.place(@cruiser, ['A1', 'A2', 'A3'])
    refute @board.cells_empty?(['A1', 'A2', 'A3'])
  end

  def test_it_can_validate_placement
    @board.add_cells
    refute @board.valid_placement?(@cruiser, ['A1', 'A2', 'A8'])
    assert @board.valid_placement?(@cruiser, ['C1', 'C2', 'C3'])
    refute @board.valid_placement?(@submarine, ['A1', 'C1'])
    refute @board.valid_placement?(@cruiser, ['A3', 'A2', 'A1'])
    refute @board.valid_placement?(@submarine, ['C1', 'B1'])
  end

  def test_it_can_check_for_diagonal_coordinates
    assert_equal false, @board.valid_placement?(@cruiser, ['A1', 'B2', 'C3'])
    assert_equal false, @board.valid_placement?(@submarine, ['C2', 'D3'])
  end

  def test_it_validates_coordinates
    @board.add_cells
    assert_equal true, @board.valid_placement?(@submarine, ['A1', 'A2'])
    assert_equal true, @board.valid_placement?(@cruiser, ['B1', 'C1', 'D1'])
  end

  def test_it_can_place_new_ships
    @board.add_cells
    @board.place(@cruiser, ['A1', 'A2', 'A3'])
    assert_equal @board.cells['A1'].ship, @cruiser
    assert_equal @board.cells['A2'].ship, @cruiser
    assert_equal @board.cells['A3'].ship, @cruiser
    assert @board.cells['A2'].ship == @board.cells['A3'].ship
    assert_equal 'Invalid placement.', @board.place(@cruiser, ['A1', 'A2', 'C3'])
  end

  def test_it_can_detect_overlapping_ships
    @board.add_cells
    @board.place(@cruiser, ['A1', 'A2', 'A3'])
    assert_equal false, @board.valid_placement?(@submarine, ['A1', 'B1'])
  end

  def test_it_can_render_board
    @board.add_cells
    @board.place(@cruiser, ['A1', 'A2', 'A3'])
    @board.place(@submarine, ['D3', 'D4'])
    false_show = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal false_show, @board.render
    true_show = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . S S \n"
    assert_equal true_show, @board.render(true)
  end
end
