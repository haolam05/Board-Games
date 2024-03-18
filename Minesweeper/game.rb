require_relative 'board'
require 'yaml'

class Game
    def initialize
        @leaderboard = []
    end

    def set_up
        case chosen_level
        when 'B'
            @board = Board.new 
        when 'I'
            @board = Board.new(16, 16, 40) 
        when 'E'
            @board = Board.new(16, 30, 99)
        when 'C'
            length, width, bombs = design_custom_level.flatten
            @board = Board.new(length, width, bombs) 
        end
    end

    def chosen_level
        print "Pick a level: Beginner(B) - Intermediate(I) - Expert(E) - Custom(C): "
        level = take_input
        level.length == 1 && !level.first.nil? && 'BIEC'.include?(level.first.upcase) ? level.first.upcase : chosen_level
    end

    def design_custom_level
        puts "Enter the game size(ex: 9x9) followed by the number of bombs(ex: 10) desired in this format: 9x9 10"
        puts "Keep in mind that the number of bombs must be at least ONE and size must be at least 1x1."
        print "Enter here: "
        size, bombs = take_input
        valid_size?(size) && valid_bombs?(bombs) ? [size.split('x').map(&:to_i), bombs.to_i] : design_custom_level
    end

    def valid_size?(size)
        size.split('x').map(&:to_i).all? { |n| n >= 1 }
    end

    def valid_bombs?(bombs)
        !bombs.nil? && bombs.to_i >= 1
    end

    def play
        set_up
        start_time = Time.now
        play_one_round until game_over?
        win? ? print_winner_message : print_loser_message
        @board.print_board
        time = time_to_finish(start_time)
        save_game if save_game?
        print_leaderboard(time)
        play if play_again?
    end

    def print_leaderboard(time)
        result = (win? ? 'win' : 'lose')
        puts "\nHere is the leaderboard:"
        puts "Game\t\tSize\t\tTime(s)\t\t    Result"
        @leaderboard << ["#{@board.length}x#{@board.width}", time, result]
        @leaderboard.each_with_index do |info, i| 
            print "#{i + 1}"
            info.each { |el| print "#{el}".rjust(19) }
            puts
        end
    end

    def time_to_finish(start_time)
        time = (Time.now - start_time).round(1)
        puts "\nIt takes you #{time} seconds to finish the game."
        puts
        time
    end

    def play_again?
        puts "\nAnswer 'y' for YES or 'n' for NO."
        puts "Do you want to player again?"
        print "Enter here: "
        response = take_input.join('')
        response.downcase == 'y' ? true : false
    end

    def save_game
        puts "Enter a file name you wanted to save: "
        print "Enter here: "
        file_name = take_input.join('')
        File.write(file_name, YAML.dump(self))
    end

    def save_game?
        puts "Answer 'y' for YES or 'n' for NO."
        puts "Do you want to save this game result?"
        print "Enter here: " 
        response = take_input.join('')
        response.downcase == 'y' ? true : false
    end

    def print_loser_message
        puts "You LOSE!! It is a BOMB!!"
    end

    def print_winner_message
        puts "Congratulation! You WIN!"
    end
    
    def play_one_round
        @board.print_board
        pos, command = get_command

        case command
        when 'f'
            @board.flag(pos)
        when 'uf'
            @board.unflag(pos)
        when 'r'
            @current_position = pos
            @board.reveal_tile(pos)
        end
    end

    def get_command
        puts "Commands explaination: 1) 'f': flag   2) 'r': reveal\t3)   'uf': unflag"
        print "Enter a position(ex: 5,5) followed by a command(ex: r) in this format: 5,5 r\n"
        print "Enter here: "
        pos, command = take_input
        position = pos.split(',').map(&:to_i)
        valid_position?(position, command) ? [position, command] : get_command
    end

    def valid_position?(position, command)
        !command.nil? && position.length == 2 && position.first.between?(0, @board.length - 1) && position.last.between?(0, @board.width - 1)
    end

    def game_over?
        win? || lose? 
    end

    def win?
        found_all_bombs?
    end

    def lose?
        step_on_bombs?
    end

    def step_on_bombs?
        @board.board.flatten.any? { |tile| tile.revealed? } ? @board[current_position].bombed? : false
    end

    def found_all_bombs?
        @board.safe_positions.all? { |pos| @board[pos].revealed?}
    end
    
    def take_input
        gets.chomp.split(' ')
    end

    private
    attr_reader :current_position
end

if $PROGRAM_NAME == __FILE__
  case ARGV.count                       # running as script
  when 0
    Game.new.play
  when 1
    YAML.load_file(ARGV.shift).play     #resume game, using 1st argument
  end
end