require_relative 'test_helper'
require './lib/ship'

class ShipTest < MiniTest::Test
  def setup
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def test_it_exists_and_starts_with_attributes_health_and_not_sunk
    assert_instance_of Ship, @cruiser
    assert_equal 'Cruiser', @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
    refute @cruiser.sunk?

    assert_instance_of Ship, @submarine
    assert_equal 'Submarine', @submarine.name
    assert_equal 2, @submarine.length
    assert_equal 2, @submarine.health
    refute @submarine.sunk?
  end

  def test_it_sinks_after_three_hits
    @cruiser.hit
    assert_equal 2, @cruiser.health
    refute @cruiser.sunk?

    @cruiser.hit
    assert_equal 1, @cruiser.health
    refute @cruiser.sunk?

    @cruiser.hit
    assert @cruiser.sunk?

    @submarine.hit
    assert_equal 1, @submarine.health
    refute @submarine.sunk?

    @submarine.hit
    assert @submarine.sunk?
  end
end
