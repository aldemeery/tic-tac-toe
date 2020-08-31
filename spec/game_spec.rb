require 'tty-prompt'
require_relative '../lib/game'
require_relative '../lib/engine'
require_relative '../lib/player'

describe Game do
  let(:player_x) { Player.new('X', 'John') }
  let(:player_o) { Player.new('O', 'John') }
  let(:engine) { Engine.new }
  let(:dimension) { 3 }

  describe '#initialize' do
    it 'sets attributes correctly' do
      prompt = TTY::Prompt.new
      game = Game.new(prompt, engine, player_x, player_o, dimension)

      expect(game).to have_attributes(prompt: prompt,
                                      engine: engine,
                                      player_x: player_x,
                                      player_o: player_o,
                                      dimension: dimension)
    end
  end
end
