#!/usr/bin/env ruby
require_relative 'image'

class CommandLineParser

def run
  i = 0
  begin
    i +=1
    method_name = process_user_input.first
  rescue NoMethodError
    puts "No image initialized. Please use 'I' to initialize a new image first."
  rescue Exception => e  
    puts e.message
  end until i > 1000 or method_name =~ /^X/ 
end

def process_user_input
  print "> "
  user_input = gets.chomp
  arguments = user_input.split(' ').map{|arg| (arg == "0" || arg.to_i != 0) ? arg.to_i : arg }
  method_name = arguments.shift.to_sym
  if user_input =~ /^I/
    initialise_new_image(*arguments)
  else
    @image.send(method_name, *arguments) unless method_name =~ /^X/
  end
  [method_name, *arguments]
end

def initialise_new_image(*arguments)
  @image = Image.new(*arguments)
end

end
