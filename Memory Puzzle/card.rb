class Card
    attr_reader :value, :current_status

    def initialize(value)
        @status = ['down', 'up'] 
        @current_status = @status.first
        @value = value
    end

#to hide the card, make the card face DOWN
    def hide
        @current_status = down
    end

#helper method of hide, return 'down'
    def down
        @status.first
    end

#revealed the card, make the card face UP
    def reveal
        @current_status = up
    end
 
#helper method of reveal, return 'up'
    def up
        @status.last
    end
    
#print out the card if it is revealed, if not, do nothing
    def to_s
        revealed? ? value : " "
    end

#return a boolean to see if the card is facing up
    def revealed?
        @current_status == up
    end

#check if value between 2 cards are equal
    def ==(other_card)   #Card
        other_card.is_a?(self.class) && self.value == other_card.value
    end
end