require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player

    def initialize(n_length)
        @player = Player.new
        @board = Board.new(n_length)
        @remaining_misses = @board.size / 2
    end

    def start_game
        @board.place_random_ships
        puts @board.num_ships
        @board.print
    end

    def lose?
        if @remaining_misses > 0
            return false
        end
        puts 'you lose'
        true
    end

    def win?
        return false if @board.num_ships != 0
        print 'you win'
        true
    end

    def game_over?
        win? || lose?
    end

    def turn
        @remaining_misses -= 1 if !@board.attack(@player.get_move)
        @board.print
        puts @remaining_misses
    end
end
