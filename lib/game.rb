require 'tty-table'
require 'tty-box'
require 'pastel'
require_relative './helpers'
require_relative './engine'

# Defining the Game class.
class Game
  def initialize(prompt, player_x, player_o, dimension = 3)
    @prompt = prompt
    @player_x = player_x
    @player_o = player_o
    @board = Array.new(dimension**2)
    @turn = 0 
  end

  def start
    cls
    first_player_name, second_player_name = player_names
    puts TTY::Box.frame(first_player_name, 'V.S.', second_player_name, align: :center, width: 25)

    table = TTY::Table.new([[1, 2, 3], :separator, [4, 5, 6], :separator, [7, 8, 9]])
    puts table.render(:unicode, padding: [1, 3])
    puts first_player_name + ' is the winner! Hurray!!'
    @prompt.keypress('Press any key to continue...')
  end

  private

  def player_names
    pastel = Pastel.new(eachline: "\n")
    first_player = pastel.cyan("#{@player_x.name} (#{@player_x.symbol})")
    second_player = pastel.magenta("#{@player_o.name} (#{@player_o.symbol})")

    [first_player, second_player]
  end
end
