class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship == nil
      return @fired_upon = true
    elsif @ship == ship
      @fired_upon = true
      @ship.hit
    end
  end

  def render(cell_ship_display = false)
    if @fired_upon == false && cell_ship_display == false
      print "."
      return "."
    elsif @fired_upon == false && @ship == ship && cell_ship_display == true
      print "S"
      return "S"
    elsif @fired_upon == true && @ship == nil
      print "M"
      return "M"
    elsif @fired_upon == true && @ship == ship && @ship.sunk? == false
      print "H"
      return "H"
    elsif @fired_upon == true && @ship.sunk? == true
      print "X"
      return "X"
    end
  end
end
