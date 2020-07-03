# Defining the engine class.
class Engine
  def initilize; end

  def winning?(board, last_move)
    @dimension = Math.sqrt(board.size).to_i
    @board = board
    @last_move = last_move
    row_index = row
    column_index = column

    winning_row = evaluate(:next_right, row_index * @dimension)
    winning_column = evaluate(:next_below, column_index)

    winning_diagonal = false

    winning_diagonal = evaluate_diagonal(column_index, row_index) if diagonal?(column_index, row_index)

    winning_row || winning_column || winning_diagonal
  end

  private

  def evaluate_diagonal(column_index, row_index)
    diagonal_index = diagonal(column_index, row_index)
    diagonal_index.zero? ? evaluate(:next_right_diagonal, 0) : evaluate(:next_left_diagonal, @dimension - 1)
  end

  def evaluate(direction, index)
    cell = @board[index]
    winning = true
    (@dimension - 1).times do
      index = send(direction, index)
      winning &= cell.eql?(@board[index])
    end
    winning
  end

  def next_right(index)
    index + 1
  end

  def next_left(index)
    index - 1
  end

  def next_below(index)
    index + @dimension
  end

  def next_left_diagonal(index)
    next_left(next_below(index))
  end

  def next_right_diagonal(index)
    next_right(next_below(index))
  end

  def row
    row_number = (@last_move / @dimension).to_i
    (@last_move % @dimension).zero? ? row_number - 1 : row_number
  end

  def column
    column_number = (@last_move % @dimension).to_i
    (@last_move % @dimension).zero? ? @dimension - 1 : column_number - 1
  end

  def diagonal(column, row)
    return 0 if column == row
    return (@dimension - 1) if (column + row + 1) == @dimension

    raise Error, 'Cell is not on a diagonal'
  end

  def diagonal?(column, row)
    column == row || (column + row) == @dimension - 1
  end
end
