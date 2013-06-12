class Image
  attr_reader :height, :width

  def initialize(m, n)
    raise ArgumentError, "Invalid dimensions! Image must be less than 250 x 250 pixels and must be at least 1 x 1 pixels." if m < 1 || m > 250 || n < 1 || n > 250
    @height, @width, @pixels = n, m, (1..n).map{ (1..m).map{ "O" } }
  end

  def set_colour(x,y,colour)
    validate_colour_and_confirm_positions_within_image([x],[y],colour)
    @pixels[y-1][x-1] = colour
  end
  alias_method :L, :set_colour

  def draw_vertical_line(x,y1,y2,colour)
    raise ArgumentError, "Y1 must be less than Y2" if y1 > y2
    validate_colour_and_confirm_positions_within_image([x],[y1,y2],colour)
    (y1..y2).each{ |y| set_colour(x,y,colour) }
  end
  alias_method :V, :draw_vertical_line

  def draw_horizontal_line(x1,x2,y,colour)
    raise ArgumentError, "X1 must be less than X2" if x1 > x2
    validate_colour_and_confirm_positions_within_image([x1,x2],[y],colour)
    (x1..x2).each{ |x| set_colour(x,y,colour) }
  end
  alias_method :H, :draw_horizontal_line

  def to_s
    @pixels.map{ |row| row.join(' ') + "\n" }.join
  end

  def show
    print self
  end
  alias_method :S, :show

  def clear
    (1..@height).each do |y|
      (1..@width).each{ |x| set_colour(x, y, "O") }
    end
  end
  alias_method :C, :clear

  def fill(x, y, colour)
    validate_colour_and_confirm_positions_within_image([x],[y],colour)
    original_colour = get_colour(x,y)
    recursive_fill(x, y, colour, original_colour)
  end
  alias_method :F, :fill


  private

  def validate_colour_and_confirm_positions_within_image(x_values, y_values, colour)
    raise ArgumentError, "'#{colour}' is not a valid colour. Colours must be specified with a capital letter." unless colour =~ /[A-Z]/
    raise ArgumentError, "Error! Ensure X-value(s) is greater than zero and less than the image height: #{@width}" unless x_values.all? {|x| x > 0 && x <= @width}
    raise ArgumentError, "Error! Ensure Y-value(s) is greater than zero and less than the image height: #{@height}" unless y_values.all? {|y| y > 0 && y <= @height}
  end

  def method_missing(method_name, *args, &block)
    raise RuntimeError, "Command '#{method_name}' not recognized.\n Please enter one of the following:\n I (to initialize a new image)\n C (to clear the current image)\n L (to colour a particular pixel)\n V (to draw a vertical line)\n H (to draw a horizontal line)\n F (to fill a region)\n S (to show the image)\n X (to exit)"
  end

  def get_colour(x, y)
    @pixels[y-1][x-1]
  end

  def recursive_fill(x, y, colour, original_colour)
    set_colour(x, y, colour)
    positions_adjacent_to(x, y).each do |p|
      recursive_fill(*p, colour, original_colour) if get_colour(*p) == original_colour
    end
  end

  def positions_adjacent_to(x, y)
    adjacent_rows(y).map do |row|
      adjacent_colums(x).map{ |column| [column, row] } 
    end.flatten(1) - [[x,y]]
  end

  def adjacent_rows(y)
    (y-1..y+1).select{ |row| row > 0 && row <= height }
  end

  def adjacent_colums(x)
    (x-1..x+1).select{ |column| column > 0 && column <= width }
  end

end