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
    @status = true unless fired_upon?
    @ship.hit unless empty?
  end

  def render(show = false)
    return 'M' if empty? && fired_upon?
    return 'S' if !empty? && !fired_upon? && show == true
    return '.' if empty? || (!empty? && !fired_upon?)
    return 'X' if !empty? && fired_upon? && @ship.sunk?
    return 'H' if !empty? && !@ship.sunk?
  end
end
