require 'card'

describe Card do
    subject(:card) { Card.new(9, 's') }

    describe '#initialize' do
        it 'set the value' do
            expect(card.val).to eq 9
        end

        it 'set the suit' do
            expect(card.suit).to eq 's'
        end

        it 'raises error for invalid suit' do
            expect { Card.new(9, 'm') }.to raise_error InvalidSuitError
        end

        it 'raises error for invalid val' do
            expect { Card.new(0, 's') }.to raise_error InvalidValueError
        end
    end
end