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
    @command_line_parser.must_respond_to :process_user_input
  end

  it "should delegate commands to the Image class" do
    stubbed_command_line_parser = CommandLineParser.new
    stubbed_command_line_parser.stub(:gets, "L 5 6 C") do
      # redefine the 'initialise_new_image' method to generate a mock image instead of an actual image
      def stubbed_command_line_parser.initialise_new_image(*arguments)
        @image = MiniTest::Mock.new
      end
      mock_image = stubbed_command_line_parser.initialise_new_image(10, 10)
      mock_image.expect(:send, true, [:L, 5, 6, "C"])
      stubbed_command_line_parser.process_user_input
      mock_image.verify
    end
  end

  it "should handle all exceptions" do
      stubbed_command_line_parser = CommandLineParser.new
      stubbed_command_line_parser.stub(:gets, "L 5 6 C") do
      def stubbed_command_line_parser.initialise_new_image(*arguments)
        raise Exception
      end
      stubbed_command_line_parser.run
    end
  end

end