require_relative 'cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {}
    @board_letters = []
    @board_numbers = []
  end

  def add_cells(board_size)
    @board_letters = ('A'..(board_size[0].to_s)).to_a
    @board_numbers = ('1'..(board_size[-1].to_s)).to_a

    @board_letters.each do |letter|
      @board_numbers.each do |number|
        coordinate = letter + number
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
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
    letters = coordinates.map { |coordinate| coordinate[0] }
    letters.each_cons(2).all? { |a, b| b.ord - a.ord == 1 }
  end

  def numbers_consecutive?(coordinates)
    numbers = coordinates.map { |coordinate| coordinate[1].to_i }
    numbers.each_cons(2).all? { |a, b| (b - a) == 1 }
  end

  def cells_empty?(coordinates)
    coordinates.each { |coordinate| return false if !cells[coordinate].empty? }
  end

  def valid_placement?(ship, coordinates)
    return false if !coordinates.all? { |coordinate| valid_coordinate?(coordinate) }
    return false if !valid_size?(ship, coordinates) || !cells_empty?(coordinates)
    return true if letters_consecutive?(coordinates) && numbers_same?(coordinates)
    return true if letters_same?(coordinates) && numbers_consecutive?(coordinates)
    return false
  end

  def place(ship, coordinates)
    return 'Invalid placement.' if !valid_placement?(ship, coordinates)
    coordinates.each { |coordinate| cells[coordinate].place_ship(ship) }
  end

  def render(show = false)


    coordinates_list = []
    lines_list = []
    lines_list << "  " + @board_numbers.join(' ').to_s + "\n"

    @board_letters. each do |letter|
      coordinates_list = @cells.select { |name, cell| name[0] == letter }.keys

      line = "#{letter} #{coordinates_list.map { |coordinate| @cells[coordinate].render(show)}.join(" ")}" + "\n"
      lines_list << line
    end
    lines_list.join
  end
end
