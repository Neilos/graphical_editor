#!/usr/bin/env ruby
require_relative 'image'

class CommandLineParser

  def run
    user_input = get_user_input
    process_input(user_input)
  rescue NoMethodError => error
    puts "No image initialized. Please use 'I' to initialize a new image first."
  rescue StandardError => error  
    puts error.message
  end

  def get_user_input
    print "> "
    gets.chomp
  end

  def process_input(user_input)
    arguments = user_input.split(' ').map{|arg| (arg == "0" || arg.to_i != 0) ? arg.to_i : arg }
    method_name = arguments.shift.to_sym
    case method_name
    when /I/
      initialise_new_image(*arguments)
    when /X/
      exit
    else
      @image.send(method_name, *arguments)
    end
  end

  def initialise_new_image(*arguments)
    @image = Image.new(*arguments)
  end

end
