class HumanPlayer
    attr_reader :mark

    def initialize(value)
        @mark = value
    end

# HumanPlayer#get_position(legal_positions)
# Refactor this method to accept an array of positions as an argument. If the user enters a position that is not inside 
# of the array argument, tell them that their choice was illegal and prompt them to enter another. This method should 
# continue to prompt the user until they make a legal choice.

    def get_position(legal_positions, game, mark)
        position = nil

        while !legal_positions.include?(position)
            puts "Player #{mark}, enter two numbers representing a position in the format 'row col'. ex: 3 3"
            position = gets.chomp.split.map(&:to_i)
        end
        
        position
    end
end

# player = HumanPlayer.new(:X5)
# p player
# p player.get_position([[1,1],[2,2]])

