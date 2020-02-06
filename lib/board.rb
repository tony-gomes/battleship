require_relative 'cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {}
  end

  def add_cells
    ycoords = ('A'..'D').to_a
    xcoords = ('1'..'4').to_a

    ycoords.each do |letter|
      xcoords.each do |number|
        coordinate = letter + number
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
    @cells
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_size?(ship, coordinates)
    ship.length == coordinates.length
  end

  def letters_same?(coordinates)
    coordinates.all? { |coordinate| coordinate[0] == coordinates[0][0] }
  end

  def numbers_same?(coordinates)
    coordinates.all? { |coordinate| coordinate[1] == coordinates[0][1] }
  end

  def letters_consecutive?(coordinates)
    coordinates[0][0].ord.next == coordinates[1][0].ord
  end

  def numbers_consecutive?(coordinates)
    coordinates[0][1].next == coordinates[1][1]
  end

  def cells_empty?(coordinates)
    return false if coordinates.all? { |coordinate| valid_coordinate?(coordinate) } == false
    coordinates.all? { |coordinate| @cells[coordinate].ship == nil }
  end

  def valid_placement?(ship, coordinates)
    return false if !valid_size?(ship, coordinates) || !cells_empty?(coordinates)
    return true if letters_same?(coordinates) && numbers_consecutive?(coordinates)
    return true if letters_consecutive?(coordinates) && numbers_same?(coordinates)
    return false
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        ship_place = @cells[coordinate].ship
        ship_place = ship
      end
      @cells
    end
  end
end
