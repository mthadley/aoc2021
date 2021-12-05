class Point
  attr_reader :x, :y

  def self.[](x, y) = new(x, y)

  def initialize(x, y)
    @x = x
    @y = y
    freeze
  end

  %i[+ - * /].each do |op|
    define_method(op) { |*args| bin_op(op, *args) }
  end

  def ==(other)
    return false unless other.is_a?(self.class)

    x == other.x && y == other.y
  end
  alias_method :eql?, :==

  def hash = [x, y].hash

  def inspect = "(#{x.inspect}, #{y.inspect})"

  def to_point = self

  private

  def bin_op(op, other)
    other = other.to_point
    self.class[x.public_send(op, other.x),
               y.public_send(op, other.y)]
  end
end

class Numeric
  def to_point = Point[self, self]
end
