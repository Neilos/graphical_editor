
class Image
attr_reader :height, :width

def initialize(m, n)
  @width = m
  @height = n
  @pixels = (1..m).map{ (1..n).map{ "O" } }
end

def colour_at_position(x, y)
  @pixels[x-1][y-1]
end

def set_colour_at_position(x,y,colour)
  @pixels[x-1][y-1] = colour
end

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

def show
  @pixels.map{|row| row.join(' ') + "\n"}.join
end

def adjacent_positions(x,y)
  (y-1..y+1).map { |y_value| (x-1..x+1).map { |x_value| [x_value, y_value] } }.flatten(1) - [[x,y]]
end


end