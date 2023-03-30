class InvalidSuitError < StandardError
    def message
        'invalid suit!'
    end
end

class InvalidValueError < StandardError
    def message
        'invalid value!'
    end
end

class IdenticalCardsError < StandardError
    def message
        'a deck does not have 2 identical cards!'
    end
end

class NotFiveCardsError < StandardError
    def message
        'a hand needs exactly 5 cards!'
    end
end

class TooManyPlayersError < StandardError
    def message
        'poker game contains no more than 6 players!'
    end
end

class NotEnoughPlayersError < StandardError
    def message
        'poker game needs at least 2 players!'
    end
end