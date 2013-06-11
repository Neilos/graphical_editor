
class Image
attr_reader :height, :width

def initialize(m, n)
  @height, @width = n, m
  @pixels = (1..n).map{ (1..m).map{ "O" } }
end

def set_colour(x,y,colour)
  @pixels[y-1][x-1] = colour
end

def draw_vertical_line(x,y1,y2,colour)
  raise ArgumentError, "y1 must be less than y2" if y1 > y2
  raise ArgumentError, "co-ordinates must be within the bounds of the image" if x > @width || y2 > @height || x < 1 || y1 < 1
  (y1..y2).each { |y| set_colour(x,y,colour) }
end

def draw_horizontal_line(x1,x2,y,colour)
  raise ArgumentError, "x1 must be less than x2" if x1 > x2
  raise ArgumentError, "co-ordinates must be within the bounds of the image" if x1 < 1 || x2 < 1 || x2 > @width || y < 1 || y > @height
  (x1..x2).each { |x| set_colour(x,y,colour) }
end

def to_s
  @pixels.map{ |row| row.join(' ') + "\n" }.join
end

def show
  print self
end

def clear
  (0..@height-1).each do |y|
    (0..@width-1).each { |x| set_colour(x, y, "O") }
  end
end

def fill(x, y, colour)
  original_colour = get_colour(x,y)
  recursive_fill(x, y, colour, original_colour)
end


private

def get_colour(x, y)
  @pixels[y-1][x-1]
end

def recursive_fill(x, y, colour, original_colour)
  set_colour(x, y, colour)
  positions_adjacent_to(x, y).each do |p|
    recursive_fill(*p, colour, original_colour) if get_colour(*p) == original_colour
  end
end

def positions_adjacent_to(x,y)
  adjacent_rows(y).map do |row|
    adjacent_colums(x).map{ |column| [column, row] } 
  end.flatten(1) - [[x,y]]
end

def adjacent_colums(x)
  (x-1..x+1).select{ |column| column > 0 && column <= width }
end

def adjacent_rows(y)
  (y-1..y+1).select{ |row| row > 0 && row <= height }
end

end