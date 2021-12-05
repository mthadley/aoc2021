class Point
  attr_reader :x, :y

  def self.[](x, y)
    new(x, y)
  end

  def initialize(x, y)
    @x = x
    @y = y
    freeze
  end

  def +(other)
    other = other.to_point
    self.class[x + other.x, y + other.y]
  end

  def *(other)
    other = other.to_point
    self.class[x * other.x, y * other.y]
  end

  def ==(other)
    return false unless other.is_a?(self.class)

    x == other.x && y == other.y
  end
  alias_method :eql?, :==

  def hash = [x, y].hash

  def inspect = "(#{x.inspect}, #{y.inspect})"

  def to_point = self
end

class Integer
  def to_point = Point[self, self]
end
