#!/usr/bin/env ruby
require './lib/command_line_parser'

graphical_editor = CommandLineParser.new

loop do
  graphical_editor.run
end