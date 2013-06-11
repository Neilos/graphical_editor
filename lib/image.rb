
class Image
attr_reader :height, :width

def initialize(m, n)
  @width = m
  @height = n
  @pixels = (1..n).map{ (1..m).map{ "O" } }
end

def colour_at_position(x, y)
  @pixels[y-1][x-1]
end

def set_colour_at_position(x,y,colour)
  @pixels[y-1][x-1] = colour
end

# DELETE
# def set_colour_at_multiple_positions(colour, positions)
#   # each position p in the positions array is itself an array of x and y co-ordinates [x,y]
#   positions.each do |p|
#     set_colour_at_position(*p, colour)
#   end
# end
# DELETE

def draw_vertical_line(x,y1,y2,colour)
  raise ArgumentError, "y1 must be less than y2" if y1 > y2
  (y1..y2).each do |y|
    set_colour_at_position(x,y,colour)
  end
end

def draw_horizontal_line(x1,x2,y,colour)
  raise ArgumentError, "x1 must be less than x2" if x1 > x2
  (x1..x2).each do |x|
    set_colour_at_position(x,y,colour)
  end
end

def to_s
  @pixels.map{|row| row.join(' ') + "\n"}.join
end

def show
  puts self
end

def adjacent_positions(x,y)
  (y-1..y+1).map { |y_value| (x-1..x+1).map { |x_value| [x_value, y_value] } }.flatten(1) - [[x,y]]
end

def clear
  (0..@height-1).map do |y|
    (0..@width-1).map do |x|
      set_colour_at_position(x, y, "O")
    end
  end
end

def fill(x, y, colour)
  original_colour = colour_at_position(x,y)
  recursive_fill(x, y, colour, original_colour)
end

def recursive_fill(x, y, colour, original_colour)
  set_colour_at_position(x, y, colour)
  adjacent_positions(x, y).each do |position|
    recursive_fill(*position, colour, original_colour) if colour_at_position(*position) == original_colour
  end
end

end