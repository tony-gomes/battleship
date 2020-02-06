class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    if @cells[coordinate].nil?
      false
    else
      true
    end
  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      return false
    end

    letter_comparison_array = []
    number_comparison_array = []

    coordinates.each do |coordinate|
      letter_comparison_array << coordinate[0]
      number_comparison_array << coordinate[1].to_i
    end

    if letter_comparison_array.uniq.length == 1 && number_comparison_array.each_cons(2).all? { |a, b| (b - a) == 1 }
      return true
    elsif number_comparison_array.uniq.length == 1 && letter_comparison_array.each_cons(2).all? { | a, b| b.ord - a.ord == 1}
      return true
    else
      false
    end
  end
end
