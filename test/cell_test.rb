require_relative 'test_helper'
require './lib/ship'
require './lib/cell'


class CellTest < Minitest::Test
  def setup
    @cell1 = Cell.new("B4")
    @cell2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists_with_attributes_and_starts_empty
    assert_instance_of Cell, @cell1
    assert_equal "B4", @cell1.coordinate
    assert_nil @cell1.ship
    assert @cell1.empty?
  end

  def test_it_can_place_ship
    @cell1.place_ship(@cruiser)
    assert_equal @cruiser, @cell1.ship
    refute @cell1.empty?
  end

  def test_it_can_be_fired_upon_and_it_can_fire_upon
    refute @cell1.fired_upon?
    @cell1.fire_upon
    assert @cell1.fired_upon?

    @cell1.place_ship(@cruiser)
    @cell1.fire_upon
    assert_equal 2, @cruiser.health
    assert @cell1.fired_upon?
  end

  def test_it_can_render_cells
    assert_equal ".", @cell1.render
    @cell1.fire_upon
    assert_equal "M", @cell1.render

    @cell2.place_ship(@cruiser)
    assert_equal ".", @cell2.render
    assert_equal "S", @cell2.render(true)

    @cell2.fire_upon
    assert_equal "H", @cell2.render
    refute @cruiser.sunk?

    2.times { @cruiser.hit }
    assert @cruiser.sunk?
    assert_equal "X", @cell2.render
  end
end
