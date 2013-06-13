class Image
  attr_reader :height, :width

  def initialize(width, height)
    validate_initialization_parameters(width, height)
    @height, @width, @pixels = height, width, (1..height).map{ (1..width).map{ "O" } }
  end

  def set_colour(x,y,colour)
    validate_colour_and_confirm_positions_within_image([x],[y],colour)
    @pixels[y-1][x-1] = colour
  end

  def draw_vertical_line(x,y1,y2,colour)
    validate_colour_and_confirm_positions_within_image([x],[y1,y2],colour)
    (y1..y2).each{ |y| set_colour(x,y,colour) }
  end

  def draw_horizontal_line(x1,x2,y,colour)
    validate_colour_and_confirm_positions_within_image([x1,x2],[y],colour)
    (x1..x2).each{ |x| set_colour(x,y,colour) }
  end

  def show
    print self
  end

  def clear
    (1..@height).each do |y|
      (1..@width).each{ |x| set_colour(x, y, "O") }
    end
  end

  def fill(x, y, colour)
    validate_colour_and_confirm_positions_within_image([x],[y],colour)
    original_colour = get_colour(x,y)
    recursive_fill(x, y, colour, original_colour)
  end

  def to_s
    @pixels.map{|row| row.join(' ') + "\n" }.join
  end

private

  def validate_initialization_parameters(width, height)
    raise ArgumentError, ERROR_MESSAGES[:invalid_dimensions] if width<1 || width>250 || height<1 || height>250
  end

  def validate_colour_and_confirm_positions_within_image(x_values, y_values, colour)
    raise ArgumentError, "'#{colour}'" + ERROR_MESSAGES[:invalid_colour] unless colour =~ /[A-Z]/ && !colour.nil?
    raise ArgumentError, ERROR_MESSAGES[:invalid_x_values] + "#{width}" if x_values.any? {|x| x<=0 || x>width}
    raise ArgumentError, ERROR_MESSAGES[:invalid_y_values] + "#{@height}" if y_values.any? {|y| y<=0 || y>@height}
    raise ArgumentError, ERROR_MESSAGES[:x_args_wrong_order] if x_values.first > x_values.last
    raise ArgumentError, ERROR_MESSAGES[:y_args_wrong_order] if y_values.first > y_values.last
  end

  def method_missing(method_name, *args, &block)
    raise RuntimeError, "Error! Command '#{method_name}'" + ERROR_MESSAGES[:unrecognized_command]
  end

  def get_colour(x, y)
    @pixels[y-1][x-1]
  end

  def recursive_fill(x, y, new_colour, old_colour)
    set_colour(x, y, new_colour)
    positions_adjacent_to(x, y).each do |p|
      recursive_fill(*p, new_colour, old_colour) if get_colour(*p) == old_colour
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

  ERROR_MESSAGES = {
    :x_args_wrong_order => "Error! Arguments are in the wrong order. X1 must be less than X2",
    :y_args_wrong_order => "Error! Arguments are in the wrong order. Y1 must be less than Y2",
    :invalid_dimensions  => "Error! Invalid dimensions. Image must be less than 250 x 250 pixels and must be at least 1 x 1 pixels.",
    :invalid_colour   => " is not a valid colour. Must be a capital letter.",
    :invalid_x_values => "Error! X-value(s) must be greater than 0 and less than image width: ",
    :invalid_y_values => "Error! Y-value(s) must be greater than 0 and less than image height: ",
    :unrecognized_command => " not recognized.\nPlease enter one of the following:\nI (to initialize a new image)\nC (to clear the current image)\nL (to colour a particular pixel)\nV (to draw a vertical line)\nH (to draw a horizontal line)\nF (to fill a region)\nS (to show the image)\nX (to exit)"
  }
end
