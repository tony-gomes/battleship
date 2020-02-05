require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists_with_attributes_and_health
    assert_instance_of Ship, @cruiser
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health

    assert_instance_of Ship, @submarine
    assert_equal "Submarine", @submarine.name
    assert_equal 2, @submarine.length
    assert_equal 2, @submarine.health
  end

  def test_starts_not_sunk?
    refute @cruiser.sunk?

    refute @submarine.sunk?
  end

  def test_it_can_hit_and_sink_ships
    @cruiser.hit
    assert_equal 2, @cruiser.health

    @cruiser.hit
    assert_equal 1, @cruiser.health

    @cruiser.hit
    assert @cruiser.sunk?

    @submarine.hit
    assert_equal 1, @submarine.health

    @submarine.hit
    assert @submarine.sunk?
  end
end
