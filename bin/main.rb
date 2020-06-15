#!/usr/bin/env ruby

require 'tty-prompt'
require_relative '../lib/logo'
require_relative '../lib/helpers'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/engine'

cls # Clear the command line.

puts logo # A method returnin the logo defined in './logo.rb'.
sleep(1) # Let the players enjoy the logo for one second.

cls # Clear the command line.

# Initialize essential variables.
prompt = TTY::Prompt.new
engine = Engine.new
player_x = nil
player_o = nil
dimension = 3 # Board area: 3 x 3.
x_symbol = 'X'.freeze
o_symbol = 'O'.freeze

# Game loop.
loop do
  # Define the options dynamically.
  options = {} # Reset options.
  # You shouldn't enter your name if you have done already.
  options['Play again'] = :a if !player_x.nil? && !player_o.nil?

  options['Play a new game'] = :n

  options['Quit'] = :q

  cls # Clear the command line.

  # Main menu.
  command = prompt.select('What do you want to do?', options)

  # Maybe players don't know they want to play more.
  if command == :q
    cls # Clear the command line.
    command = prompt.select('Play a bit more? (∩_∩)', { "Yeah, let's rock!" => :y, "Nah, I'll just leave" => :q })
    break if command == :q # Players still want to quit, let's break out the game loop.

    next # Players changed their mind :D.
  end

  # Create the players.
  if command == :n
    player_x = Player.new(x_symbol, prompt.ask("First player's name: ", required: true), { color: :cyan })
    player_o = Player.new(o_symbol, prompt.ask("Second player's name: ", required: true), { color: :magenta })
  end

  # Let the game begin
  # Let the game begin
  game = Game.new(prompt, player_x, player_o, engine, dimension)
  game.start
end

# It's their choice to quit.
puts "Fine! don't come back! (╯°□°)╯ ┻━┻"
