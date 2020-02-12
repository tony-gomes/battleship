require_relative 'test_helper'
require './lib/computer'
require './lib/user'
require './lib/game'
require './lib/modules/playable'

class GameTest < MiniTest::Test
  def setup
    @game = Game.new
  end

  def test_it_can_setup_players
    assert_instance_of Computer, @game.computer
    assert_instance_of User, @game.user
  end
end
