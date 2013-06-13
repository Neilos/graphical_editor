require 'bundler/setup'
require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require '../lib/command_parser'
require 'mocha/setup'

describe CommandParser do
  before do
    @command_line_parser = CommandParser.new
  end 

  it "should have a run method" do
    @command_line_parser.must_respond_to :run
  end

  it "should be able to initialise new images" do
    @command_line_parser.stubs(:get_user_input).returns("I 10 10").at_least_once
    @command_line_parser.run
    @command_line_parser.send(:image).must_be_instance_of Image
  end

  it "should delegate commands to its current image when processing user input" do
    @command_line_parser.stubs(:get_user_input).returns("I 10 10").then.returns("L 5 6 C")
    @command_line_parser.run
    mock_image = @command_line_parser.send(:image)
    mock_image.expects(:set_colour).with(5, 6, "C").at_least_once
    @command_line_parser.run
  end

  it "should call the exit method when the user enters 'X'" do
    @command_line_parser.expects(:exit).returns(true).once
    @command_line_parser.send(:process_input, 'X')
  end

  it "should handle all appropriate image errors when being run" do
    @command_line_parser.stubs(:get_user_input).raises(RuntimeError).then.raises(ArgumentError).then.raises(NoMethodError)
    @command_line_parser.run
    @command_line_parser.run
    @command_line_parser.run
  end

end