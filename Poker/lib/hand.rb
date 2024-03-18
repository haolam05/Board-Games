require_relative 'errors'
require_relative 'card'
require_relative 'hand_info'

class Hand
    attr_reader :identity, :val_to_suit
    attr_accessor :hand_values

    def initialize(cards)
        raise NotFiveCardsError if cards.length != 5
        set_identity(cards)
    end

    def compare(hand_instance)
        identity == hand_instance.identity ? compare_same_rank(self, hand_instance) : compare_different_rank(identity, hand_instance.identity)
    end

protected
    def get_cards(hand, n = nil)
        hand = hand.hand_values
        hand = hand.select { |card_val, quantity| quantity == n }  if !n.nil?
        hand.map { |card_val, quantity| get_values[card_val] }
    end

private
    def set_identity(cards)
        quantify_vals_and_suits(cards)
        @identity = get_identity
    end

    def get_identity
        if four_of_a_kind?
            :four_of_a_kind
        elsif three_of_a_kind?
            one_pair? ? :full_house : :three_of_a_kind
        elsif one_pair?
            two_pair? ? :two_pair : :one_pair
        elsif flush?
            straight? ? :straight_flush : :flush
        elsif straight?
            :straight
        else
            :high_card
        end
    end

    def quantify_vals_and_suits(cards)
        @hand_values = Hash.new(0)
        @val_to_suit = {}

        cards.each do |card| 
            @hand_values[card.val] += 1 
            @val_to_suit[card.val] = card.suit
        end
    end

    def compare_different_rank(rank1, rank2)
        HandInfo.new.ranks.index(rank1) > HandInfo.new.ranks.index(rank2) ? 1 : -1
    end

    def compare_same_rank(hand1, hand2)
        if [:straight_flush, :flush, :straight, :high_card].include?(hand1.identity)
            get_cards(hand1).max <=> get_cards(hand2).max                                   # compare_highest_card(hand1, hand2)
        elsif [:full_house, :four_of_a_kind, :three_of_a_kind].include?(hand1.identity)
            get_values[sorted_hand(hand1)] <=> get_values[sorted_hand(hand2)]               # compare_highest_kind(hand1, hand2)
        elsif [:one_pair]
            compare_one_pair(hand1, hand2) 
        else 
            compare_two_pairs(hand1, hand2)                 
        end                        
    end

    def compare_two_pairs(hand1, hand2)
        two_pairs1, two_pairs2 = get_cards(hand1, 2), get_cards(hand2, 2)
        any_bigger_pair?(two_pairs1, two_pairs2) ? 1 : (any_bigger_pair?(two_pairs2, two_pairs1) ? -1 : (get_cards(hand1, 1) <=> get_cards(hand2, 1)))
    end

    def compare_one_pair(hand1, hand2)
        pair1, pair2 = get_values[sorted_hand(hand1)], get_values[sorted_hand(hand2)]
        (pair1 <=> pair2) == 0 ? get_cards(hand1, 1).uniq.max <=> get_cards(hand2, 1).uniq.max : pair1 <=> pair2
    end

    def any_bigger_pair?(pairs1, pairs2)
        pairs1.any? { |pair1| pairs2.all? { |pair2| pair1 > pair2 } }
    end

    def get_values
        HandInfo.new.values_table
    end

    def sorted_hand(hand)
        hand.hand_values.sort_by { |k, v| v }.last.first
    end

    def flush?
        val_to_suit.values.all? { |suit| suit == val_to_suit.values.first }
    end
    
    def straight?                                
        (0...hand_values.keys.length - 1).all? do |i| 
            current_card = get_values[hand_values.keys[i]] + 1
            next_card = get_values[hand_values.keys[i + 1]] 
            current_card == next_card || (current_card == 15 && next_card == 2)
        end
    end
    
    def straight_flush?
        flush? && straight? 
    end

    def four_of_a_kind?
        hand_values.values.any? { |val| val == 4 }
    end

    def two_pair?
        hand_values.values.count { |val| val == 2 } == 2
    end

    def one_pair?
        hand_values.values.any? { |val| val == 2 }
    end

    def three_of_a_kind?
        hand_values.values.any? { |val| val == 3 }
    end

    def full_house?
        one_pair? && three_of_a_kind?
    end
end