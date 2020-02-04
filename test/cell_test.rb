require_relative 'test_helper'
require './lib/cell'
require './lib/ship'

class CellTest < MiniTest::Test
  def setup
    @cell_1 = Cell.new('B4')
    @cell_2 = Cell.new('C3')
  end

  def test_it_exists_with_attributes_and_starts_empty
    assert_instance_of Cell, @cell_1
    assert_equal 'B4', @cell_1.coordinate
    assert_nil @cell_1.ship
    assert @cell_1.empty?
  end

  def test_it_can_place_ships
    cruiser = Ship.new('Cruiser', 3)
    @cell_1.place_ship(cruiser)

    assert_equal cruiser, @cell_1.ship
    refute @cell_1.empty?
  end

  def test_it_starts_not_fired_upon_and_can_be_fired_upon
    refute @cell_1.fired_upon?
    @cell_1.fire_upon

    cruiser = Ship.new('Cruiser', 3)
    @cell_1.place_ship(cruiser)

    @cell_1.fire_upon
    assert_equal 2, @cell_1.ship.health
    assert @cell_1.fired_upon?
  end

  def test_it_can_render_cells
    assert_equal '.', @cell_1.render
    @cell_1.fire_upon
    assert_equal 'M', @cell_1.render

    cruiser = Ship.new('Cruiser', 3)
    @cell_2.place_ship(cruiser)
    assert_equal '.', @cell_2.render
    assert_equal 'S', @cell_2.render(true) # Indicate that we want to show a ship with the optional argument

    @cell_2.fire_upon
    assert_equal 'H', @cell_2.render
    refute cruiser.sunk?

    2.times { cruiser.hit }
    assert cruiser.sunk?
    assert_equal 'X', @cell_2.render
  end
end
