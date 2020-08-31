require 'tty-table'
require 'tty-box'
require 'pastel'
require 'colorize'
require_relative './helpers'
require_relative './player'

# Defining the Game class.
class Game
  attr_reader :prompt, :engine, :player_x, :player_o, :dimension

  def initialize(prompt, engine, player_x = nil, player_o = nil, dimension = 3)
    @prompt = prompt
    @engine = engine
    @player_x = player_x
    @player_o = player_o
    @dimension = dimension || 3
    reset
  end

  def run
    loop do
      options = set_options
      cls
      command = @prompt.select('What do you want to do?', options)

      if command == :q
        break if sure # Players still want to quit, let's break out the game loop.

        next # Players changed their mind :D.
      end

      if command == :n
        @player_x = Player.new('X', @prompt.ask("First player's name: ", required: true), { color: :cyan })
        @player_o = Player.new('O', @prompt.ask("Second player's name: ", required: true), { color: :magenta })
      end

      start
    end
  end

  private

  def sure
    cls
    @prompt.select('Play a bit more? (∩_∩)', { "Yeah, let's rock!" => :y, "Nah, I'll just leave" => :q }) == :q
  end

  def start
    reset
    cls
    winner = nil

    while @board.any?(nil)
      if (winner = next_turn)
        break
      end
    end

    display_winner(winner)
    @prompt.keypress('Press any key to continue...')
  end

  def set_options
    options = {} # Reset options.
    options['Play again'] = :a if !@player_x.nil? && !@player_o.nil?
    options['Play a new game'] = :n
    options['Quit'] = :q

    options
  end

  def reset
    @board = Array.new(@dimension**2)
    @turn = 0
    @taken = []
  end

  def next_turn
    update_display
    next_move = prompt_next_move(@taken)

    @board[next_move - 1] = current_player
    @taken << next_move

    if possible_to_win && @engine.winning?(@board, next_move)
      update_display
      return current_player
    end
    @turn += 1

    nil
  end

  def update_display
    cls
    draw_box(@player_x.display_name, 'V.S.', @player_o.display_name, {})
    draw_table
  end

  def display_winner(winner)
    if winner
      draw_box((winner.display_name + ' is the winner! Hurray!!').colorize(:green), { width: 50 })
    else
      draw_box("No one is winning! It's a tie!!".colorize(:yellow), { width: 50 })
    end
  end

  def possible_to_win
    @turn >= (@dimension * 2) - 2
  end

  def draw_box(*args, options)
    options = { align: :center, width: 25 }.merge(options)
    puts TTY::Box.frame(*args, options)
  end

  def draw_table
    table = TTY::Table.new(generate_table)
    puts table.render(:unicode, padding: [1, 3])
  end

  def prompt_next_move(except = [])
    ok = false
    until ok
      next_move = @prompt.ask("#{current_player.display_name} (1..#{@dimension**2}): ") do |q|
        q.required(true)
        q.in((1..(@dimension**2)))
      end
      except.include?(next_move.to_i) ? @prompt.error('This square is already taken') : ok = true
    end
    next_move.to_i
  end

  def generate_table
    table = []
    @board.each_slice(@dimension).with_index do |row, index|
      table << parse_row(row, index)
      table << :separator
    end
    table
  end

  def parse_row(row, row_index)
    row.map!.with_index do |cell, cell_index|
      cell.nil? ? ((cell_index + 1) + (row_index * @dimension)).to_s : cell.display_symbol
    end
  end

  def current_player
    @turn.even? ? @player_x : @player_o
  end
end
