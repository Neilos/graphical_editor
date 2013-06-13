require 'bundler/setup'
require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require '../lib/command_line_parser'
require 'mocha/setup'

describe CommandLineParser do
  before do
    @command_line_parser = CommandLineParser.new
  end 

  it "should have a run method" do
    @command_line_parser.must_respond_to :run
  end

  it "should be able to initialise new images" do
    @command_line_parser.initialise_new_image(10, 10).must_be_instance_of Image
  end

  it "should be able to process user input" do
    @command_line_parser.must_respond_to :process_input
  end

  it "should be able to get user input" do
    @command_line_parser.must_respond_to :get_user_input
  end

  it "should get input from the user" do
    @command_line_parser.stubs(:gets).returns "A"
    @command_line_parser.get_user_input.must_equal "A"
  end

  it "should delegate commands to its current image when processing user input" do
    mock_image = @command_line_parser.initialise_new_image(10, 12)
    mock_image.expects(:L).with(5, 6, "C").at_least_once
    @command_line_parser.process_input("L 5 6 C")
  end

  it "should call the exit method when the user enters 'X'" do
    @command_line_parser.expects(:exit).returns(true).once
    @command_line_parser.process_input('X')
  end

  it "should handle all appropriate errors when being run" do
    @command_line_parser.stubs(:get_user_input).raises(StandardError).then.raises(RuntimeError).then.raises(ArgumentError).then.raises(NoMethodError)
    @command_line_parser.run
    @command_line_parser.run
    @command_line_parser.run
    @command_line_parser.run
  end

end