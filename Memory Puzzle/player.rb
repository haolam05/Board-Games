class HumanPlayer
    def player_input(legal_guess_positions, board = nil, matches = nil)
        puts "Here are legal positions you can chose from: #{legal_guess_positions}\n"
        prompt
        gets.chomp.split.map(&:to_i)
    end

private
    def prompt
        print "Please enter a position: "
    end
end

class ComputerPlayer
    def initialize
        @known_cards = []
        @known_idx = []
    end

    def player_input(legal_guess_positions, board, matches)
        @board = board
        @matches = matches

        if first_guess?
            get_known_pair
            known_idx.length == matches ? choose_known_pair : make_random_guess(legal_guess_positions)
        else
            (known_idx.length < matches && known_idx.length > 0) ? choose_known_pair : make_random_guess(legal_guess_positions)
        end 
    end

private
    attr_reader :known_cards, :known_idx
    
    def get_known_pair
        i = 0

        while i < known_cards.length
            count_matches = []
            (0...known_cards.length).each { |j| count_matches << j if not_a_star?(i) && not_a_star?(j) && get_value(j) == get_value(i) }
            @known_idx = count_matches if count_matches.length == @matches
            i += 1
        end
    end

    def first_guess?
        known_cards.count { |pos| pos != '*' } % @matches == 0
    end

    def make_random_guess(legal_guess_positions)
        @known_cards << (legal_guess_positions.select { |pos| !known_cards.include?(pos) }.sample)
        known_cards.last
    end

    def choose_known_pair
        idx = @known_idx.shift
        card = known_cards[idx]
        @known_cards[idx] = '*'
        card
    end

    def not_a_star?(i)
        known_cards[i] != '*'
    end

    def get_value(i)
        @board[known_cards[i]].value 
    end
end