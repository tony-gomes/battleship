class Ship
  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @status = false
  end

  def sunk?
    @status
  end

  def hit
    @health == 1 ? @status = true : @health -= 1
  end
end
