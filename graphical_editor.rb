#!/usr/bin/env ruby

require './lib/image'


begin
  print "> "
  user_input = gets.chomp
  arguments = user_input.split(' ').map{|e| e.to_i > 0 ? e.to_i : e }
  method_name = arguments.shift.to_sym
  @image = nil

  
  @image.send(method_name, *arguments)

  case user_input
  when /I \d+ \d+/
    @image  = Image.new(*arguments)
    puts method_name
    puts arguments.inspect
  when /C/
    # @image.send(method)

  when /L \d+ \d+ [A-Z]/
    puts method_name
    puts arguments.inspect
  
  when /V \d+ \d+ \d+ [A-Z]/
    puts method_name
    puts arguments.inspect
  
  when /H \d+ \d+ \d+ [A-Z]/
    puts method_name
    puts arguments.inspect
  
  when /F \d+ \d+ [A-Z]/
    puts method_name
    puts arguments.inspect
  
  when /S/
    puts method_name
    puts arguments.inspect

  else
    puts "unknown"

  end

end until user_input == 'X'