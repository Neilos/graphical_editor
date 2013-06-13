#!/usr/bin/env ruby
require_relative 'image'

class CommandParser
  attr_accessor :image
  private :image

  IMAGE_COMMANDS = {
    :C => :clear,
    :L => :set_colour,
    :V => :draw_vertical_line,
    :H => :draw_horizontal_line,
    :F => :fill,
    :S => :show
  }

  def run
    process_input(get_user_input)
  rescue NoMethodError => error
    puts "No image initialized. Please use 'I' to initialize a new image first."
  rescue StandardError => error  
    puts error.message
  end


private

  def get_user_input
    print "> "
    gets.chomp
  end

  def process_input(input)
    arguments = input.split(' ').map{|arg| (arg == "0" || arg.to_i != 0) ? arg.to_i : arg }
    method = arguments.shift.upcase.to_sym
    execute_commands(method, arguments)
  end

  def execute_commands(method, arguments)
    exit if method == :X
    initialise_new_image(*arguments) if method == :I
    image.send(IMAGE_COMMANDS[method], *arguments) unless (method == :X || @image.nil?)
  end

  def initialise_new_image(*arguments)
    @image = Image.new(*arguments)
    puts "image initialized"
  end

end
