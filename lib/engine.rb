require 'pry'
# Defining the engine class.
class Engine
  def initilize; end

  def evaluate(board, last_move)
    @dimension = Math.sqrt(board.size).to_i
    @board = board
    @last_move = last_move
    row = row
    column = column
    if diagonal?(column, row)
    end
  end

  private

  def row
    row_number = (@last_move / @dimension).to_i
    (@last_move % @dimension).zero? ? row_number - 1 : row_number
  end

  def column
    column_number = (@last_move % @dimension).to_i
    (@last_move % @dimension).zero? ? @dimension - 1 : column_number - 1
  end

  def diagonal?(column, row)
    column == row || (column + row) == @dimension - 1
  end
end
