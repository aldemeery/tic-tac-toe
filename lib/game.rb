require 'tty-table'
require 'tty-box'
require 'pastel'
require 'pry'
require 'colorize'
require_relative './helpers'

# Defining the Game class.
class Game
  def initialize(prompt, player_x, player_o, engine, dimension = 3)
    @prompt = prompt
    @player_x = player_x
    @player_o = player_o
    @engine = engine
    @dimension = dimension
    @board = Array.new(dimension**2)
    @turn = 0
    @taken = []
  end

  def start
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

  private

  def next_turn
    draw_box(@player_x.display_name, 'V.S.', @player_o.display_name, {})
    draw_table

    next_move = prompt_next_move(@taken)

    @board[next_move - 1] = current_player
    @taken << next_move

    return current_player if possible_to_win && @engine.evaluate(@board, next_move)

    @turn += 1
    cls

    nil
  end

  def display_winner(winner)
    if winner
      draw_box((winner.display_name + ' is the winner! Hurray!!').colorize(:blue), { width: 50 })
    else
      draw_box("No one is winning! It's a tie!!".colorize(:yellow), { width: 50 })
    end
  end

  def possible_to_win
    @turn >= (@dimension * 2) - 1
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
      cell.nil? ? ((cell_index + 1) + (row_index * @dimension)).to_s : cell.symbol
    end
  end

  def current_player
    @turn.even? ? @player_x : @player_o
  end
end
