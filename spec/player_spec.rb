require_relative '../lib/player'

describe Player do
  let(:player) { Player.new('X', 'John') }

  context '#attributes' do
    it 'allows reading for @symbol and @name' do
      expect(player.symbol).to eq('X')
      expect(player.name).to eq('John')
    end
  end
end
