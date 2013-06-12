#!/usr/bin/env ruby
require './lib/image'

begin
  print "> "
  user_input = gets.chomp
  arguments = user_input.split(' ').map{|arg| (arg == "0" || arg.to_i != 0) ? arg.to_i : arg }
  method_name = arguments.shift.to_sym
  if user_input =~ /^I/
    @image  = Image.new(*arguments)
  else
    @image.send(method_name, *arguments) unless method_name =~ /^X/
  end
rescue NoMethodError
  puts "No image initialized. Please use 'I' to initialize a new image first."
rescue Exception => e  
  puts e.message
end until method_name =~ /^X/
