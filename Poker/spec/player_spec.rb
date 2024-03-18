require 'player'

describe Player do
    let(:cards) { [Card.new(9, 'h'), Card.new(9, 'c'), Card.new(9, 'd'), Card.new(4, 'c'), Card.new(4, 's')] }
    subject(:player) { Player.new('Hao', cards) }

    describe '#initialize' do
        it 'sets the name' do
            expect(player.name).to eq 'Hao'
        end

        it 'sets the hand' do
            expect(player.hand).to be_an_instance_of Hand
        end

        it 'sets bankroll to 100' do
            expect(player.bankroll).to eq 100
        end
    end

    describe '#next_move' do
        let(:next_move) { player.next_move }
    
        it 'returns a array of next move in the form of [command, amount]' do
            expect(next_move).to be_a Array
            expect(next_move.length).to eq 2
        end

        it 'has command as string and amount as integer' do
            expect(next_move.first).to be_a String
            expect(next_move.last).to be_a Integer
        end

        it 'has amount greater than or equal 0 and smaller than or equal to bankroll' do
            expect(next_move.last).to be >= 0
            expect(next_move.last).to be <= player.bankroll
        end

        it 'ony has 3 commands: f(fold), r(raise), c(call)' do
            expect('frc').to include next_move.first
        end
    end

    describe '#discard_cards' do
        it 'returns the total number of cards(up to 3 cards max) that the player had discarded' do
            expect([0, 1, 2, 3]).to include player.discard_cards
        end

        it 'deletes the discarded cards on hand' do
            result = 5 - player.discard_cards
            expect(player.hand.hand_values.values.sum).to eq result
        end
    end
end