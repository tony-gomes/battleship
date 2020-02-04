require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'


class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists

    assert_instance_of Cell, @cell
  end

  def test_cell_coordinate

    assert_equal "B4", @cell.coordinate
  end

  def test_cell_ship

    assert_nil nil, @cell.ship
  end

  def test_cell_empty?

    assert_equal true, @cell.empty?
  end

  def test_place_ship
    @cell.place_ship(@cruiser)

    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_cell_fired_upon?

    assert_equal false, @cell.fired_upon?
  end

  def test_cell_fire_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    cell2 = Cell.new("B4")
    cell2.fire_upon

    assert_equal 2, @cruiser.health
    assert_equal true, @cell.fired_upon?
    assert_equal true, cell2.fired_upon?
  end

  def test_cell_render
    cell2 = Cell.new("B4")
    cell2.fire_upon
    cell3 = Cell.new("B4")
    cell3.place_ship(@cruiser)
    cell3.fire_upon
    cell4 = Cell.new("C3")
    cell4.place_ship(@submarine)
    cell4.fire_upon
    @submarine.hit
    
    assert_equal ".", @cell.render
    assert_equal "S", @cell.render(true)
    assert_equal "M", cell2.render
    assert_equal "H", cell3.render
    assert_equal "X", cell4.render
  end


end
