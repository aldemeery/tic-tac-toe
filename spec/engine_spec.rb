require_relative '../lib/engine'
require_relative '../lib/game'
require_relative '../lib/player'

describe Engine do
  let(:engine) { Engine.new }
  let(:firstPlayer) { Player.new('X', 'John') }
  let(:secondPlayer) { Player.new('O', 'John') }

  describe '#winning' do
    it 'returns true when there is a winner' do
      board = [
        firstPlayer, firstPlayer, firstPlayer,
        secondPlayer, secondPlayer, nil,
        nil, nil, nil
      ]

      expect(engine.winning?(board, 3)).to eql(true)
    end

    it 'returns false when there is no winner' do
      board = Array.new(9)
      board[0] = firstPlayer

      expect(engine.winning?(board, 1)).to eql(false)
    end
  end
end
