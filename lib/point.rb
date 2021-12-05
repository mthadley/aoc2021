class Point
  attr_reader :x, :y

  def self.[](x, y) = new(x, y)

  def initialize(x, y)
    @x = x
    @y = y
    freeze
  end

  %i[+ - * /].each do |op|
    # `eval` used over `define_method` for speed
    eval <<~RUBY
      def #{op}(other)
        other = other.to_point
        self.class[x #{op} other.x, y #{op} other.y]
      end
    RUBY
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

class Numeric
  def to_point = Point[self, self]
end
