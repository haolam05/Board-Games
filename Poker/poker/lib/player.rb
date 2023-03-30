require_relative 'hand'
require_relative 'card_info'

class Player
    attr_reader :hand, :name
    attr_accessor :bankroll

    def initialize(name, cards, bankroll = 100)
        @name = name
        @hand = Hand.new(cards)
        @bankroll = bankroll
    end

    def next_move
        puts "Enter the following to commands: f(fold) - r(raise) - c(call) in this form: 'command amount'"
        print "Enter here: "
        cmd, amt = gets.chomp.split
        valid_move?(cmd, amt) ? [cmd, amt.to_i] : next_move
    end

    def discard_cards
        cards = []
        input = nil

        puts "#{name}'s turn"
        until cards.length == 3 || input == 'q'
            prompting(cards)
            input = gets.chomp
            card = to_card(input)
            cards << card if valid_card?(card)
            update_hand(card)
            system('clear')
        end

        cards.length
    end

    def print_cards_on_hand
        puts "Your cards: #{hand.hand_values}"
    end

private
    def valid_move?(cmd, amt)
        (cmd == 'f' || cmd == 'r' || cmd == 'c') && (amt.to_i <= bankroll && amt.to_i >= 0)
    end

    def prompting(cards)
        print_cards_on_hand
        puts "Enter up to 3 cards you want to discard. When finished, type 'q' to exit."
        print "Card #{cards.length + 1}: "
    end

    def update_hand(card_val)
        @hand.hand_values[card_val] -= 1
        @hand.hand_values.delete(card_val) if hand.hand_values[card_val] < 1
    end

    def hand_include_card?(card)
        @hand.hand_values.keys.include?(card)
    end

    def valid_card?(card)
        CardInfo.new.values.include?(card) && hand_include_card?(card)
    end

    def to_card(card)
        ['J', 'Q', 'K', 'A'].include?(card) ? card : card.to_i
    end
end