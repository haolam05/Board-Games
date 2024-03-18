require_relative "board"
require_relative "card"
require_relative "player"
require_relative "errors"

class Game

    def initialize(size, player)
        raise SizeError if size % 2 == 1 || size <= 0
        @board = Board.new(size)
        @guess_pos = []
        @current_guess_pos = []
        @player = player
        @count = 0
        level = select_difficulty_level
        select_match(size, level == 1)
        put_random_words_into_board(level == 1)
    end

    def play
        print_board
        play_one_round until game_over? 
        puts (@board.won? ? "Congratulation, you win!!!" : "Sorry, you lose!!!!")
    end

private
    attr_reader :current_guess_pos, :guess_pos
    GUESSES_LIMIT = 10

    def play_one_round
        reveal_cards_chosen_by_player_on_the_board
        clear_screen_and_print_board
        
        if cards_are_not_matched 
            hide_pairs
            @count += 1
        end

        clear_screen_and_print_board
    end

    def select_match(size, difficult)
        puts "Please choose the match you want: match >= 2 && match is even && (match <= size(without bombs) || match <= size/2(with bombs)"
        print "Enter here: "
        answer = gets.chomp.to_i
        select_match(size, difficult) unless answer >= 2 && answer % 2 == 0 
        select_match(size, difficult) unless (difficult ? answer <= size : answer <= size * 2)
        @cards = Array.new(answer)
    end

    def select_difficulty_level
        puts "Please choose the difficulty level of the game: (0) Easy-no bombs or (1) difficult-with bombs."
        print "Enter here: "
        answer = gets.chomp
        select_difficulty_level unless ['0', '1'].include?(answer)
        answer.to_i
    end

    def clear_screen_and_print_board
        clear_screen
        print_board
    end

    def guessed_pos
        take_player_input
    end

    def pos_is_valid?
        length_is_valid? && size_is_valid?
    end
 
    def length_is_valid?
        current_guess_pos.length == 2
    end

    def size_is_valid?
        current_guess_pos.all? { |i| (0...@board.size).include?(i) }
    end

    def game_over?
        @board.won? || GUESSES_LIMIT == @count
    end

    def step_on_bomb?
        return false if current_guess_pos.empty?
        @board[current_guess_pos].value == 'b'
    end

    def take_player_input
        get_guessed_position_from_player

        until pos_is_valid?
            print 'Invalid position. '
            get_guessed_position_from_player
        end

        add_position_to_arr
        current_guess_pos
    end

    def get_guessed_position_from_player
        @current_guess_pos = player_guessed_position

        if step_on_bomb?
            puts "You stepped on a bomb. Sorry, you lose!!!!" 
            @board.reveal(current_guess_pos)
            print_board
            exit 
        end
    end

    def player_guessed_position
        @player.player_input(legal_positions_to_guess, @board, @cards.length)
    end

    def legal_positions_to_guess
        @board.legal_guess_positions
    end

    def add_position_to_arr
        @guess_pos << current_guess_pos
    end

    def update_cards
        cards = []
        i = -1

        @cards.length.times do 
            cards << @guess_pos[i] 
            i -= 1
        end

        @cards = cards
    end    

    def make_guess
        update_cards
        @cards.all? { |pos| @board[pos] == @board[current_guess_pos] }
    end

    def put_random_words_into_board(difficult)
        @board.populate(difficult, @cards.length)

        if difficult
            @board.reveal_bombs
            print_board
            clear_screen
            @board.hide_bombs
        end
    end

    def print_board
        @board.render       
    end

    def clear_screen
        sleep(1)
        system('clear')
    end

    def reveal_cards_chosen_by_player_on_the_board
        @cards.length.times do
            puts "GUESSES LIMIT: #{GUESSES_LIMIT}\nGuesses left: #{GUESSES_LIMIT - @count}"
            reveal_this_card_on_the_board
            clear_screen_and_print_board        
        end
    end

    def reveal_this_card_on_the_board
        @board[guessed_pos].reveal
    end

    def hide_pairs
        @cards.each { |pos| @board[pos].hide }
        print "Try again"
    end

    def cards_are_not_matched
        !make_guess
    end
end

if $PROGRAM_NAME == __FILE__
    g = Game.new(4, HumanPlayer.new)
    # g = Game.new(4, ComputerPlayer.new)
    g.play
end

# Bonus
# Come back to this after you finish Sudoku!

# Implement a simple command-line interface, allowing the user to determine the difficulty of the game 
#   (i.e., the size of the board). Do this before the Game is initialized. 
#   Remember if __FILE__ == $PROGRAM_NAME!
# Enforce an upper limit on the number of turns played. If the limit is exceeded, the player loses.
# Let's add a twist: start the game by placing a certain number of "bombs" instead of normal cards. 
# When the game starts, show the bombs for 5 seconds or so; then hide them. 
#   If the player reveals a bomb, the game ends. 
#   (If you feel this is too harsh, perhaps you can implement "lives" or "hit points"). 
#   You might also want to determine the bomb count as a function of board size.
# We've already got a working "Match 2" puzzle. What about a "Match 3" or "Match 4"? 
#   Generalize your code to work for any number of matching cards.