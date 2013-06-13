require 'bundler/setup'
require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require '../lib/image'
require 'mocha/setup'

describe Image do
  before do
    @height, @width = 12, 10
    @image = Image.new(@width, @height)
  end

  it "should have the right dimensions" do
    @image.width.must_equal @width
    @image.height.must_equal @height
  end

  it "can return a colour at a particular position" do
    @image.send(:get_colour, 8,10).must_equal "O"
  end

  it "should be initialized with all positions having colour 'O'" do
    (1..@height).map do |y|
      (1..@width).map do |x|
        @image.send(:get_colour, x,y).must_equal "O", "position x=#{x},y=#{y}"
      end
    end
  end

  it "can set the colour of a particular position" do
    @image.set_colour(10,12,"C")
    @image.send(:get_colour, 10,12).must_equal "C"
  end

  it "should draw a vertical line of length 2" do
    @image.draw_vertical_line(2,3,4,"W")
    @image.send(:get_colour, 2,2).wont_equal "W", "position [2,2] is wrong"
    @image.send(:get_colour, 2,3).must_equal "W", "position [2,3] is wrong"
    @image.send(:get_colour, 2,4).must_equal "W", "position [2,4] is wrong"
    @image.send(:get_colour, 2,5).wont_equal "W", "position [2,5] is wrong"
  end

  it "should draw a vertical line of length 4" do
    @image.draw_vertical_line(5,3,6,"C")
    @image.send(:get_colour, 5,2).wont_equal "C", "position [5,2] is wrong"
    @image.send(:get_colour, 5,3).must_equal "C", "position [5,3] is wrong"
    @image.send(:get_colour, 5,4).must_equal "C", "position [5,4] is wrong"
    @image.send(:get_colour, 5,5).must_equal "C", "position [5,5] is wrong"
    @image.send(:get_colour, 5,6).must_equal "C", "position [5,6] is wrong"
    @image.send(:get_colour, 5,7).wont_equal "C", "position [5,7] is wrong"
  end

  it "should raise an error if the any of the position arguments are off the edge of the image" do
    lambda{ @image.draw_vertical_line(0,6,3,"C") }.must_raise ArgumentError
    lambda{ @image.draw_vertical_line(@width+1,6,3,"C") }.must_raise ArgumentError
    lambda{ @image.draw_vertical_line(5,0,2,"C") }.must_raise ArgumentError
    lambda{ @image.draw_vertical_line(5,6,0,"C") }.must_raise ArgumentError
    lambda{ @image.draw_vertical_line(5,6,@height+1,"C") }.must_raise ArgumentError
  end

   it "should raise an error if the y1 & y2 arguments are in the wrong order" do
    lambda{ @image.draw_vertical_line(5,6,3,"C") }.must_raise ArgumentError
  end


  it "should draw a horizontal line of length 2" do
    @image.draw_horizontal_line(3,4,2,"Z")
    @image.send(:get_colour, 2,2).wont_equal "Z", "position [2,2] is wrong"
    @image.send(:get_colour, 3,2).must_equal "Z", "position [3,2] is wrong"
    @image.send(:get_colour, 4,2).must_equal "Z", "position [4,2] is wrong"
    @image.send(:get_colour, 5,2).wont_equal "Z", "position [5,2] is wrong"
  end

  it "should draw a horizontal line of length 4" do
    @image.draw_horizontal_line(2,5,6,"W")
    @image.send(:get_colour, 1,6).wont_equal "W", "position [1,6] is wrong"
    @image.send(:get_colour, 2,6).must_equal "W", "position [2,6] is wrong"
    @image.send(:get_colour, 3,6).must_equal "W", "position [3,6] is wrong"
    @image.send(:get_colour, 4,6).must_equal "W", "position [4,6] is wrong"
    @image.send(:get_colour, 5,6).must_equal "W", "position [5,6] is wrong"
    @image.send(:get_colour, 6,6).wont_equal "W", "position [6,6] is wrong"
  end

  it "should raise an error if the any of the position arguments are off the edge of the image" do
    lambda{ @image.draw_horizontal_line(0,5,6,"W") }.must_raise ArgumentError
    lambda{ @image.draw_horizontal_line(2,0,6,"W") }.must_raise ArgumentError
    lambda{ @image.draw_horizontal_line(2,@width+1,6,"W") }.must_raise ArgumentError
    lambda{ @image.draw_horizontal_line(2,5,0,"W") }.must_raise ArgumentError
    lambda{ @image.draw_horizontal_line(2,5,@height+1,"W") }.must_raise ArgumentError
  end

  it "should raise an error if the x1 & x2 arguments are in the wrong order" do
    lambda{ @image.draw_horizontal_line(5,2,6,"W") }.must_raise ArgumentError
  end

  it "has a string representation" do
    image_string = (("O " * @width).rstrip + "\n") * @height
    @image.to_s.must_equal image_string
  end

  it "can show itself" do
    @image.must_respond_to :show
  end

  it "should know the positions adjacent to a particular position" do
    correct_answer = [[2,3],[3,3],[4,3],[2,4],[4,4],[2,5],[3,5],[4,5]].sort
    @image.send(:positions_adjacent_to, 3, 4).sort.must_equal correct_answer
  end

  it "should not return adjacent positions outside the bounds of the image" do
    correct_answer = [[9,11],[10,11],[9,12]].sort
    @image.send(:positions_adjacent_to, 10, 12).sort.must_equal correct_answer
  end

  it "can clear all the positions by setting all the positions to white (O)" do
    @image.draw_horizontal_line(2,5,6,"W")
    @image.draw_horizontal_line(3,4,2,"Z")
    @image.draw_vertical_line(5,3,6,"C")
    @image.clear
    (0..@height-1).each do |y|
      (0..@width-1).each do |x|
        @image.send(:get_colour, x,y).must_equal "O"
      end
    end
  end
  
  it "should fill cells in a range" do
    @image.draw_horizontal_line(3,9,3,"Z")
    @image.draw_horizontal_line(3,9,9,"Z")
    @image.draw_vertical_line(3,3,9,"Z")
    @image.draw_vertical_line(9,3,9,"Z")
    @image.fill(5,6,"A")
    filled_image_region_string = "O O O O O O O O O O\nO O O O O O O O O O\nO O Z Z Z Z Z Z Z O\nO O Z A A A A A Z O\nO O Z A A A A A Z O\nO O Z A A A A A Z O\nO O Z A A A A A Z O\nO O Z A A A A A Z O\nO O Z Z Z Z Z Z Z O\nO O O O O O O O O O\nO O O O O O O O O O\nO O O O O O O O O O\n"
    @image.to_s.must_equal filled_image_region_string
  end

  it "should fill cells in a range when that range is on the edge of the image" do
    @image.draw_horizontal_line(7,10,6,"Z")
    @image.draw_vertical_line(7,7,12,"Z")
    puts
    puts @image.show
    @image.fill(1,1,"A")
    filled_image_region_string = "A A A A A A A A A A\nA A A A A A A A A A\nA A A A A A A A A A\nA A A A A A A A A A\nA A A A A A A A A A\nA A A A A A Z Z Z Z\nA A A A A A Z O O O\nA A A A A A Z O O O\nA A A A A A Z O O O\nA A A A A A Z O O O\nA A A A A A Z O O O\nA A A A A A Z O O O\n"
    @image.to_s.must_equal filled_image_region_string
    puts
    puts @image.show
  end

  it "should raise a RuntimeError if called with an unrecognized method" do
    lambda{ @image.unknown_method }.must_raise RuntimeError
  end

end


