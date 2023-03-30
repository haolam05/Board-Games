require_relative 'card'
require_relative 'card_info'

class Deck 
    attr_accessor :deck

    def initialize
        @deck = CardInfo.new.values.product(CardInfo.new.suits).map { |(val, suit)| Card.new(val, suit) }
        shuffle!
    end

private
    def shuffle!
        @deck.shuffle!
    end

    def render
        puts "#{deck[0..12].map { |card| "#{card.val}-#{card.suit}" }}"
        puts "#{deck[13..25].map { |card| "#{card.val}-#{card.suit}" }}"
        puts "#{deck[26..38].map { |card| "#{card.val}-#{card.suit}" }}"
        puts "#{deck[39..51].map { |card| "#{card.val}-#{card.suit}" }}"
    end
end