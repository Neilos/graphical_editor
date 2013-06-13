#!/usr/bin/env ruby
require './lib/command_parser'

graphical_editor = CommandParser.new

loop do
  graphical_editor.run
end