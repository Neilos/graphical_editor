#!/usr/bin/env ruby
require_relative 'image'

class CommandParser
  attr_accessor :image
  private :image

  IMAGE_COMMANDS = { :C => :clear, :L => :set_colour,  :V => :draw_vertical_line,
                     :S => :show,  :F => :fill,        :H => :draw_horizontal_line }
  def run
    process_input(get_user_input)
  rescue NoMethodError => error
    puts "No image initialized. Please use 'I' to initialize a new image first."
  rescue RuntimeError, ArgumentError => error  
    puts error.message
  end

private

  def get_user_input
    print "> "
    gets.chomp
  end

  def process_input(input)
    arguments = input.split(' ').map{|arg| (arg == "0" || arg.to_i != 0) ? arg.to_i : arg }
    command = arguments.shift.upcase.to_sym
    execute(command, arguments)
  end

  def execute(command, arguments)
    return exit if command == :X
    return initialise_new_image(*arguments) if command == :I
    delegate_to_image(command, arguments)
  end

  def initialise_new_image(*arguments)
    @image = Image.new(*arguments)
  end

  def delegate_to_image(command, arguments)
    method = IMAGE_COMMANDS[command] || :unrecognized
    image.send(method, *arguments)
  end

end
