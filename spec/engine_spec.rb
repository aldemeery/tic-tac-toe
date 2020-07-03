require_relative '../lib/engine'
require_relative '../lib/game'
require_relative '../lib/player'

describe Engine do
  let(:engine) { Engine.new }
  let(:firstPlayer) { Player.new('X', 'John') }
  let(:secondPlayer) { Player.new('O', 'John') }

  describe '#winning' do
    it 'returns true when there is a horizontal winner' do
      board = [
        firstPlayer, firstPlayer, firstPlayer,
        secondPlayer, secondPlayer, nil,
        nil, nil, nil
      ]

      expect(engine.winning?(board, 3)).to eql(true)
    end

    it "doesn't return true when there isn't a horizontal winner" do
      board = [
        firstPlayer, firstPlayer, secondPlayer,
        secondPlayer, firstPlayer, nil,
        nil, nil, nil
      ]

      expect(engine.winning?(board, 3)).to_not eql(true)
    end

    it 'returns true when there is a vertical winner' do
      board = [
        firstPlayer, secondPlayer, secondPlayer,
        firstPlayer, nil, nil,
        firstPlayer, nil, nil
      ]

      expect(engine.winning?(board, 7)).to eql(true)
    end

    it "doesn't true when there isn't a vertical winner" do
      board = [
        firstPlayer, secondPlayer, firstPlayer,
        firstPlayer, nil, nil,
        secondPlayer, nil, nil
      ]

      expect(engine.winning?(board, 7)).to_not eql(true)
    end

    it 'returns true when there is a diagonal winner' do
      board = [
        firstPlayer, secondPlayer, secondPlayer,
        nil, firstPlayer, nil,
        nil, nil, firstPlayer
      ]

      expect(engine.winning?(board, 9)).to eql(true)
    end

    it "doesn't return true when there isn't a diagonal winner" do
      board = [
        firstPlayer, secondPlayer, firstPlayer,
        nil, secondPlayer, nil,
        nil, nil, firstPlayer
      ]

      expect(engine.winning?(board, 9)).to_not eql(true)
    end

    it 'returns false when there is no winner' do
      board = Array.new(9)
      board[0] = firstPlayer

      expect(engine.winning?(board, 1)).to eql(false)
    end

    it "doesn't return true when there is no winner" do
      board = Array.new(9)
      board[0] = firstPlayer

      expect(engine.winning?(board, 1)).not_to eql(true)
    end
  end
end
