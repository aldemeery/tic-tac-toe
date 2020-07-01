#!/usr/bin/env ruby

require 'tty-prompt'
require 'colorize'
require_relative '../lib/logo'
require_relative '../lib/helpers'
require_relative '../lib/game'
require_relative '../lib/engine'

cls # Clear the command line.

puts logo # A method returnin the logo defined in './logo.rb'.
sleep(1) # Let the players enjoy the logo for one second.

cls # Clear the command line.

# Initialize essential variables.
prompt = TTY::Prompt.new
engine = Engine.new

# Let the game begin.
game = Game.new(prompt, engine)
game.run
cls

# It's their choice to quit.
puts "Fine! don't come back! (╯°□°)╯ ┻━┻".colorize(:red)
