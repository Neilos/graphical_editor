require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require '../lib/image'

describe Image do
  before do
  end

  it "should have the right dimensions" do
    image = Image.new(10,12)
    image.width.must_equal 10
    image.height.must_equal 12
  end

  it "should have possible colours" do
    Image::COLOUR.must_include "O"
    Image::COLOUR.must_include "C"
  end

  it "can return a colour at a particular position" do
    image = Image.new(10,12)
    image.colour_at_position(8,10).must_equal "O"
  end

  it "can set the colour of a particular position" do
  end

  it "" do
  end

end
