require './board.rb'
require './human_player.rb'
require './computer_player.rb'
require 'byebug'
class Game

# Game#initialize
# An instance of Game will now need to track an array of many players instead of just two. Make this an instance variable. 
# Allow your #initialize to accept any number of mark values. The number of marks passed to #initialize will decide 
# how many players are in the game.
    attr_reader :board

    def initialize(n, players)   
        @players = players.map { |mark, computer| computer ? SuperComputerPlayer.new(mark) : HumanPlayer.new(mark) }
        @current_player = @players.first
        @board = Board.new(n)
    end

    def switch_turn
        @current_player = @players.rotate!.first
    end

    def play
        until @board.over?
            @board.print
            @board.place_mark(@current_player.get_position(@board.legal_positions, self, @current_player.mark), @current_player.mark)
            return "victory #{@current_player.mark} #{@board.print}" if @board.win?(@current_player.mark)                
            switch_turn
        end

        puts 'draw'
    end
end

if __FILE__ == $PROGRAM_NAME
    t1 = Time.now
    # game = Game.new(6, o: true, x: false)
    game = Game.new(3, x: true, o: false)
    puts game.play
    puts "It took #{Time.now - t1} seconds to play this game."
end