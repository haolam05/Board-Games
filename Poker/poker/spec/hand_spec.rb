require 'hand'

describe Hand do
    subject(:high_card) { Hand.new([Card.new(9, 'h'), Card.new(6, 'c'), Card.new(3, 'c'), Card.new(4, 'c'), Card.new(10, 'c')]) }
    subject(:one_pair) { Hand.new([Card.new(9, 'c'), Card.new(9, 's'), Card.new(7, 'h'), Card.new(8, 'd'), Card.new(3, 's')]) }
    subject(:two_pairs) { Hand.new([Card.new(3, 'c'), Card.new(3, 'd'), Card.new("A", 'h'), Card.new("A", 's'), Card.new(5, 'd')]) }
    subject(:three_of_a_kind) { Hand.new([Card.new(9, 'c'), Card.new(9, 's'), Card.new(9, 'h'), Card.new(8, 'd'), Card.new('K', 's')]) }
    subject(:straight) { Hand.new([Card.new(3, 'h'), Card.new(4, 'c'), Card.new(5, 's'), Card.new(6, 'c'), Card.new(7, 'c')]) }
    subject(:flush) { Hand.new([Card.new(10, 'c'), Card.new(4, 'c'), Card.new(5, 'c'), Card.new(6, 'c'), Card.new(7, 'c')]) }
    subject(:full_house) { Hand.new([Card.new(9, 'c'), Card.new(9, 's'), Card.new(9, 'h'), Card.new(8, 'd'), Card.new(8, 's')]) }
    subject(:four_of_a_kind) { Hand.new([Card.new(9, 'c'), Card.new(9, 's'), Card.new(9, 'h'), Card.new(9, 'd'), Card.new('K', 's')]) }
    subject(:straight_flush) { Hand.new([Card.new(3, 'c'), Card.new(4, 'c'), Card.new(5, 'c'), Card.new(6, 'c'), Card.new(7, 'c')]) }

    describe '#initialize' do
        it 'raises error unless the hand has exactly 5 cards' do
            expect { Hand.new([Card.new(2, 'd')]) }.to raise_error NotFiveCardsError
        end

        it 'sets identity for the the hand' do
            expect(HandInfo.new.ranks).to include two_pairs.identity
        end
    end

    describe '#compare' do
        subject(:straight_flush1) { Hand.new([Card.new(10, 's'), Card.new('J', 's'), Card.new('Q', 's'), Card.new('K', 's'), Card.new('A', 's')]) }


        it 'correctly compared the different rank' do
            expect(straight_flush.compare(four_of_a_kind)).to eq 1
            expect(four_of_a_kind.compare(full_house)).to eq 1
            expect(full_house.compare(flush)).to eq 1
            expect(flush.compare(straight)).to eq 1
            expect(straight.compare(three_of_a_kind)).to eq 1
            expect(three_of_a_kind.compare(two_pairs)).to eq 1
            expect(two_pairs.compare(one_pair)).to eq 1
            expect(one_pair.compare(high_card)).to eq 1
        end

        it 'correctly compared the same rank' do
            expect(straight_flush.compare(straight_flush1)).to eq -1
            expect(straight_flush.compare(straight_flush)).to eq 0
        end
    end
end

# cards = [ Card.new("A", 'c'), Card.new("A", 'd'), Card.new("A", 'h'), Card.new("A", 's'), Card.new(2, 'd') ]

# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.four_of_a_kind?

# puts '++++++'

# cards = [ Card.new(3, 'c'), Card.new("A", 'd'), Card.new("A", 'h'), Card.new("A", 's'), Card.new(2, 'd') ]
# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.four_of_a_kind?

# puts '++++++'

# cards = [ Card.new(3, 'c'), Card.new(3, 'd'), Card.new("A", 'h'), Card.new("A", 's'), Card.new("A", 'd') ]
# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.full_house?

# puts '++++++'

# cards = [ Card.new(3, 'c'), Card.new(3, 'd'), Card.new("A", 'h'), Card.new("A", 's'), Card.new(5, 'd') ]
# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.two_pair?

# cards = [ Card.new(3, 'c'), Card.new(5, 'c'), Card.new(7, 'c'), Card.new(8, 'c'), Card.new(9, 'c') ]
# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.flush?

# puts "Straight:"
# cards = [ Card.new(3, 's'), Card.new(4, 'd'), Card.new(5, 'c'), Card.new(6, 'c'), Card.new(7, 'h') ]
# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.straight?

# cards = [ Card.new("A", 's'), Card.new(2, 'd'), Card.new(3, 'c'), Card.new(4, 'c'), Card.new(5, 'h') ]
# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.straight?

# cards = [ Card.new(10, 's'), Card.new('J', 'd'), Card.new('Q', 'c'), Card.new('K', 'c'), Card.new('A', 'h') ]
# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.straight?
# puts "ending straight."

# cards = [ Card.new(3, 'c'), Card.new(4, 'c'), Card.new(5, 'c'), Card.new(6, 'c'), Card.new(7, 'c') ]
# hand = Hand.new(cards)
# p hand.hand_values
# p hand.val_to_suit.values
# p hand.straight_flush?

# # when checking
# #     if 4_of_a_kind?

# #     elsif 3_of_a_kind?
# #         if one_pair?
# #             house
# #         else
# #             3_of_a_kind
# #         end

# #     elsif one_pair?
# #         if one_pair?
# #             two_pair
# #         else
# #             one_pair
# #         end

# #     elsif flush?
# #         if straight?
# #             straight_flush
# #         else
# #             flush
# #         end

# #     elsif straight?
# #         straight

# #     else
# #         high_card


# #straight_flush
# card1 = [ Card.new(3, 'c'), Card.new(4, 'c'), Card.new(5, 'c'), Card.new(6, 'c'), Card.new(7, 'c') ]
# hand1= Hand.new(card1)
# card2 = [ Card.new(3, 's'), Card.new(4, 's'), Card.new(5, 's'), Card.new(6, 's'), Card.new(7, 's') ]
# hand2 = Hand.new(card2)
# p hand1.compare(hand2)

# puts '+++++'

# #straight
# card1 = [ Card.new(3, 'h'), Card.new(4, 'c'), Card.new(5, 's'), Card.new(6, 'c'), Card.new(7, 'c') ]
# hand1= Hand.new(card1)
# card2 = [ Card.new(3, 's'), Card.new(4, 's'), Card.new(5, 's'), Card.new(6, 'h'), Card.new(7, 's') ]
# hand2 = Hand.new(card2)
# p hand1.compare(hand2)

# puts '+++++'

# #flush
# card1 = [ Card.new(10, 'c'), Card.new(4, 'c'), Card.new(5, 'c'), Card.new(6, 'c'), Card.new(7, 'c') ]
# hand1= Hand.new(card1)
# card2 = [ Card.new('J', 's'), Card.new(4, 's'), Card.new(5, 's'), Card.new(6, 's'), Card.new(7, 's') ]
# hand2 = Hand.new(card2)
# p hand1.compare(hand2)

# puts '+++++'

# #high_card
# card1 = [ Card.new(9, 'h'), Card.new(6, 'c'), Card.new(3, 'c'), Card.new(4, 'c'), Card.new(10, 'c') ]
# hand1= Hand.new(card1)
# card2 = [ Card.new(3, 'c'), Card.new(4, 's'), Card.new(5, 's'), Card.new(6, 's'), Card.new('K', 's') ]
# hand2 = Hand.new(card2)
# p hand1.compare(hand2)

# puts '+++++'

# #four_of_a_kind
# card1 = [ Card.new(9, 'c'), Card.new(9, 's'), Card.new(9, 'h'), Card.new(9, 'd'), Card.new('K', 's') ]
# hand1 = Hand.new(card1)
# card2 = [ Card.new('Q', 'c'), Card.new('Q', 's'), Card.new('Q', 'h'), Card.new('Q', 'd'), Card.new(2, 'c') ]
# hand2= Hand.new(card2)

# p hand1.compare(hand2)

# puts '+++++'

# #three_of_a_kind
# card1 = [ Card.new(9, 'c'), Card.new(9, 's'), Card.new(9, 'h'), Card.new(8, 'd'), Card.new('K', 's') ]
# hand1 = Hand.new(card1)
# card2 = [ Card.new('Q', 'c'), Card.new('Q', 's'), Card.new('Q', 'h'), Card.new('J', 'd'), Card.new(2, 'c') ]
# hand2= Hand.new(card2)

# p hand1.compare(hand2)

# puts '+++++'

# #full_house
# card1 = [ Card.new(9, 'c'), Card.new(9, 's'), Card.new(9, 'h'), Card.new(8, 'd'), Card.new(8, 's') ]
# hand1 = Hand.new(card1)
# card2 = [ Card.new('Q', 'c'), Card.new('Q', 's'), Card.new('Q', 'h'), Card.new('J', 'd'), Card.new('J', 'c') ]
# hand2= Hand.new(card2)

# p hand1.compare(hand2)

# puts '+++++'

# # one_pair
# card1 = [ Card.new(9, 'c'), Card.new(9, 's'), Card.new(7, 'h'), Card.new(8, 'd'), Card.new(3, 's') ]
# hand1 = Hand.new(card1)
# card2 = [ Card.new('Q', 'c'), Card.new('Q', 's'), Card.new(3, 'h'), Card.new('J', 'd'), Card.new(5, 'c') ]
# hand2= Hand.new(card2)

# p hand1.compare(hand2)

# puts '+++++'

# card1 = [ Card.new(9, 'd'), Card.new(9, 'h'), Card.new(7, 'h'), Card.new(8, 'd'), Card.new(3, 's') ]
# hand1 = Hand.new(card1)
# card2 = [ Card.new(9, 'c'), Card.new(9, 's'), Card.new(3, 'h'), Card.new('J', 'd'), Card.new(5, 'c') ]
# hand2= Hand.new(card2)

# p hand1.compare(hand2)

# puts '+++++'


# #two_pair
# card1 = [ Card.new(9, 'd'), Card.new(9, 'h'), Card.new(3, 'h'), Card.new(3, 'd'), Card.new(6, 's') ]
# hand1 = Hand.new(card1)
# card2 = [ Card.new(9, 'c'), Card.new(9, 's'), Card.new(7, 'h'), Card.new(7, 'd'), Card.new(5, 'c') ]
# hand2= Hand.new(card2)

# p hand1.compare(hand2)

# puts '+++++'

# card1 = [ Card.new(9, 'd'), Card.new(9, 'h'), Card.new(7, 'h'), Card.new(7, 'd'), Card.new(3, 's') ]
# hand1 = Hand.new(card1)
# card2 = [ Card.new(9, 'c'), Card.new(9, 's'), Card.new(7, 'c'), Card.new(7, 's'), Card.new(5, 'c') ]
# hand2= Hand.new(card2)

# p hand1.compare(hand2)

# puts '+++++'


#     # def compare_highest_kind(hand1, hand2)
#     #     get_values[sorted_hand(hand1)] <=> get_values[sorted_hand(hand2)]
#     # end

#     # def compare_highest_card(hand1, hand2)
#     #     get_cards(hand1).max <=> get_cards(hand2).max
#     # end