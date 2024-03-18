require 'deck'

describe Deck do
    describe '#initialize' do
        subject(:d) { Deck.new }

        it 'sets up 52 cards in a deck' do
            expect(d.deck.length).to eq 52
        end

        it 'has distinct cards' do
            d.deck.each { |card| expect(card).to be_an_instance_of(Card) }
        end

        it 'shuffles the card' do
            expect(d.deck).to_not eq Deck.new.deck
        end
    end
end