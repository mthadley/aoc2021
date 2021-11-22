require "singleton"

class AdventOfCode
  include Singleton

  def initialize
    @parts = Array.new(2)
  end

  def add_part(part, answer: nil, &block)
    @parts[part - 1] = Part.new(expected: answer, block: block)
  end

  def play!
    puts <<~OUT
      Day #{current_day_num || "?"}
      =====================
    OUT

    @parts.each.with_index do |part, i|
      play_part!(part, i + 1)
    end
  end

  private

  def play_part!(part, part_num)
    status =
      case
      when part.nil? || part.expected.nil? then "❔"
      when part.actual == part.expected then "✅"
      else "❌"
      end

    puts "Part #{part_num}: #{part&.actual} #{status}"
  end

  def current_day_num
    if /day(?<day_num>\d+)$/ =~ $PROGRAM_NAME
      day_num
    end
  end

  Part = Struct.new(:expected, :block, keyword_init: true) do
    def actual
      @actual ||= block.call
    end
  end
end
