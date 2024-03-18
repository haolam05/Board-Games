require_relative 'errors'
require_relative 'card_info'

class Card
    attr_reader :val, :suit

    def initialize(val, suit)
        raise InvalidSuitError if !CardInfo.new.suits.include?(suit)
        raise InvalidValueError if !CardInfo.new.values.include?(val)
        @val = val
        @suit = suit 
    end
end