class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @status = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @status
  end

  def fire_upon
    return 'Invalid Coordinate' if @ship.nil?
    !@status ? @status = true : 'This Cell Already Fired On'
    @ship.hit unless ship.nil?
    @ship.sunk? ? 'You Sunk My Battleship!' : 'You Hit My Battleship'
  end

  def render(show = false)
    return 'S' if show == true
    return 'X' unless fired_upon? && @ship.nil? && !@ship.sunk?
    return 'H' unless fired_upon? && !@ship.nil?
    return 'M' unless fired_upon? && @ship.nil?
    return '.' unless fired_upon?
  end
end
