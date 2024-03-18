require './board.rb'
require './human_player.rb'

class Game

# Game#initialize
# An instance of Game will now need to track an array of many players instead of just two. Make this an instance variable. 
# Allow your #initialize to accept any number of mark values. The number of marks passed to #initialize will decide 
# how many players are in the game.

    def initialize(n, *marks)
        @players = marks.map { |mark| HumanPlayer.new(mark) }
        @current_player = @players.first
        @board = Board.new(n)
    end

# Game#switch_turn
# For our switching logic, we'll use a "Round Robin" strategy. This means that players continually take turns in the same order. 
# For example, if we had players A, B, and C, then the turns would be ABCABCABC... until the game is over.
# For simplicity, we'll always designate whoever is at the front of the array as the current player. Consider using Array#rotate! to accomplish this.

    def switch_turn
        @current_player = @players.rotate!.first
    end

    def play
        while @board.empty_positions?
            @board.print
            @board.place_mark(@current_player.get_position, @current_player.mark)
            return "Player #{@current_player.mark} has won" if @board.win?(@current_player.mark)                
            switch_turn
        end

        puts 'draw'
    end
end

# game = Game.new(:x, :o, :z)

# puts game.play