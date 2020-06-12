#!/usr/bin/env ruby

require 'tty-prompt'

# cls() # Clear the command line.

# puts $logo # Global variable defined in './logo.rb'.
sleep(1) # Let the players enjoy the logo for one second.

# cls() # Clear the command line.

# Initialize essential variables.
prompt = TTY::Prompt.new
playerX = nil
playerO = nil
n = 3 # Board area: 3 x 3.
XSymbol = "X"
OSymbol = "O"

# Game loop.
loop do
    # Define the options dynamically.
    options = {} # Reset options.
    options["Play a new game"] = :n
    options["Play again"] = :a if !playerX.nil? && !playerO.nil? # You shouldn't enter your name if you have done already.
    options["Quit"] = :q

    # cls() # Clear the command line.

    # Main menu.
    command = prompt.select("What do you want to do?", options)

    # Maybe players don't know they want to play more ¯\_(ツ)_/¯.
    if command == :q
        # cls() # Clear the command line.
        command = prompt.select("Play a bit more? (∩_∩)", {"Yeah, let's rock!" => :y, "Nah, I'll just leave" => :q})
        break if command == :q # Players still want to quit, let's break out the game loop.
        next # Players changed their mind :D.
    end


    # Create the players.
    if command == :n
        # Initialize players.
    end

    # Let the game begin
    # Initialize the game
end

# It's their choice to quit ¯\_(ツ)_/¯.
# cls() # Clear the command line.
puts "Fine! don't come back! (╯°□°)╯ ┻━┻"

