require 'game'

describe Game do
    subject(:g) { Game.new(["Hao", "Min"]) }

    describe '#initialize' do
        context 'when number of players is invalid' do
            it 'raises error when there are more than 6 players or less than 2 players' do
                expect { Game.new(["H", "M", "Ha", "Mi", "Hao", "Min", "HM"]) }.to raise_error TooManyPlayersError
                expect { Game.new(["Hao"]) }.to raise_error NotEnoughPlayersError
            end
        end

        context 'when number of players is valid' do
            it 'does not raises error when there are less than 6 players and more than 1 players' do
                expect { Game.new(["Hao", "Min", "Haoo", "Minn", "Haooo", "Minnn"]) }.to_not raise_error 
                expect { Game.new(["Hao", "Min"]) }.to_not raise_error 
            end
        end

        it 'has a deck' do
            expect(g.deck).to be_an_instance_of Deck
        end

        it 'has current pot of the sum of $10 for each player' do
            expect(g.current_pot).to eq 20
        end

        it 'updated players bankroll' do
            g.current_players.each { |player| expect(player.bankroll).to eq 90 }
        end

        it 'has an array of current players' do
            expect(g.current_players).to be_a Array
            expect(g.current_players.length).to eq 2
            g.current_players.each { |player| expect(player).to be_a Player }
        end

        it 'has 0 current bet' do
            expect(g.current_bet).to eq 0
        end

        it 'updates deck' do
            expect(g.deck.deck.length).to eq 42
        end
    end
end

# g = Game.new(["Hao", "Min"])
# p g.get_deck.length
# p g.get_deck
# puts '---'

# # puts '---'
# p g.current_players.length
# p g.current_players

# puts '---'
# p g.current_pot

# puts '-----'
# p g.current_players
# g.update_bankrolls(2, 50)
# puts
# p g.current_players

# g.play