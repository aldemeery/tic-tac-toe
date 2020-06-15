require 'colorize'

# Defining the player class.
class Player
  attr_reader :name

  def initialize(symbol, name, options = {})
    @symbol = symbol
    @name = name
    @color = options[:color].nil? ? :white : options[:color]
  end

  def display_name
    "#{@name} (#{@symbol})".colorize(@color)
  end

  def symbol
    @symbol.colorize(@color)
  end
end
