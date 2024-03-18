# The Game class will be the main class that houses the instances of Board and HumanPlayer required for gameplay. 
# It will be responsible for passing data between the board and players. It will also serve to contain the main game loop.
# Be sure to require your board.rb and human_player.rb files into game.rb.

require './board.rb'
require './human_player.rb'

class Game

# Game#initialize(player_1_mark, player_2_mark)
# # An instance of Game should have instance variables for player one, player two, and the board. 
# # Design the initialize method to accept the mark values to be used for the players.
# # You should also initialize an instance variable to contain the current player. By default, 
# # player one should begin as the current player.

    def initialize(player_1_mark, player_2_mark)
        @player_1 = HumanPlayer.new(player_1_mark)
        @player_2 = HumanPlayer.new(player_2_mark)
        @current_player = @player_1
        @board = Board.new
    end

# Game#switch_turn
# This method should set the current player to the other player. Calling this method repeatedly should 
# switch the current player back and forth between the two players.

    def switch_turn
        if @current_player == @player_1
            @current_player = @player_2
        else
            @current_player = @player_1
        end
    end

# Game#play
# This method will contain the main game loop. Here is some psuedocode for the loop:
# while there exists empty positions on the board print the board get a position from the current player
# place their mark at that position of the board check if that user has won if they win, print out a 
# 'victory' message saying who won and return to end the game otherwise they did not win, so switch turns
# if we finish the while loop without returning, that means there are no more empty positions on the board 
# and noone has won, so print a 'draw' message

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

# game = Game.new(:x, :o)

# puts game.play