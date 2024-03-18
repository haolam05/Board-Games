class HumanPlayer

    attr_reader :mark

    def initialize(value)
        @mark = value
    end

    def get_position
        puts "Player #{@mark}, enter two numbers representing a position in the format `row col`"
        pos = gets.chomp.split
        raise if pos.length != 2
        pos.map(&:to_i)
    end
    
end

# player = HumanPlayer.new(:X5)
# p player
# p player.get_position

