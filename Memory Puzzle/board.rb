require_relative 'card'

class Board
    ALPHABET = ('A'..'Z').to_a
    attr_reader :size

    def initialize(size = 2)
        @size = size
        @board = Array.new(size) { Array.new(size) }
    end  

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def won?
        @board.flatten.select { |card| card.value != 'b' }.all? { |card| card.revealed? }
    end

    def reveal(guessed_pos)
        row, col = guessed_pos
        @board[row][col].reveal
    end

    def legal_guess_positions
        choose_unrevealed_positions
    end
        
    def populate(difficult, matches)    #populate should fill the board with a set of shuffled Card pairs
        pairs = cards(difficult, matches)
        (0...@board.length).each { |i| (0...@board.length).each { |j| @board[i][j] = pairs.shift } }
    end


    def reveal_bombs
        @board.flatten.each { |card| card.reveal if card.value == 'b' }
    end

    def hide_bombs
        @board.flatten.each { |card| card.hide if card.value == 'b' }
    end

    def render
        print_horizontal
        print_vertical
    end

private
    def get_index_from_size
        (0...size).to_a
    end

    def all_possible_positions
        get_index_from_size.product(get_index_from_size)
    end

    def choose_unrevealed_positions
        all_possible_positions.select { |pos| !self[pos].revealed? }
    end

    def []=(pos, value)
        row, col = pos
        @board[row][col] = value
    end

    def cards(difficult, matches)
        bombs = []
        total_spots_available_on_board = size * size 

        if difficult
            number_of_characters_needed = total_spots_available_on_board / 2 / matches
            number_of_bombs = total_spots_available_on_board - (number_of_characters_needed * matches)
            bombs = ['b']*number_of_bombs
            bombs = bombs.map { |bomb| Card.new(bomb) }
        else
            number_of_characters_needed = total_spots_available_on_board / matches
        end

        characters = ALPHABET.sample(number_of_characters_needed) * matches
        characters = characters.shuffle.map { |el| Card.new(el) } + bombs
        characters.shuffle
    end
    
    def print_horizontal
        print " "
        (0...size).each { |i| print " #{i}" }
    end

    def print_vertical
        (0...size).each do |i| 
            print "\n#{i}" 
            (0...size).each { |j| print " #{@board[i][j].to_s}" } 
        end

        puts
    end
end