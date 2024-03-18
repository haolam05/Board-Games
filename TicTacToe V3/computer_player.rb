require './node'
require 'byebug'

class ComputerPlayer

    attr_reader :mark

    def initialize(value)
        @mark = value
    end

# ComputerPlayer#get_position(legal_positions)
# Assume that this method takes in an array of positions as an argument. The method should return a random position from the array. 
# To make gameplay clear, print a message saying the computer's mark along with the position they chose.
# Unlike our new ComputerPlayer#get_position, you may recall that our old HumanPlayer#get_position did not accept any argument. 
# This discrepancy in interface will cause issues. We'll reconcile this difference next.

    def get_position(legal_positions, game, mark)
        position = legal_positions.sample                   #legal_positions[rand(0...legal_positions.length)]
        puts "Computer #{mark} chose position: #{position}"
        position
    end
end

#AI version
class SuperComputerPlayer < ComputerPlayer
    def get_position(legal_positions, game, mark)
        all_possible_moves = Node.new(game.board, mark).children.shuffle
        all_possible_moves.each { |child| return pos(child.prev_move_pos, mark) if child.win_node?(mark) }
        all_possible_moves.each { |child| return pos(child.prev_move_pos, mark) if !child.lose_node?(mark) }
        raise
    end

    def pos(position, mark)
        puts "Super Computer #{mark} chose position: #{position}"
        position
    end
end