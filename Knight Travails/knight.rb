require_relative 'polytree'
require 'byebug'

class KnightPathFinder

    L_TYPE_MOVE = [[-2, -1], [-2, 1], [2, 1], [2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]
        build_move_tree
    end

    def valid_moves(pos)
        L_TYPE_MOVE                                                  #get valid positions
            .select { |move| [pos[0] + move[0], pos[1] + move[1]].all? { |move| move.between?(0,7) } }
            .map { |move| [pos[0] + move[0], pos[1] + move[1]] }     #get next valid positions
            .select { |move| !@considered_positions.include?(move) } #select positions that not yet being considered
    end

    def next_move_positions(pos)                                     
        update_considered_positions_and_return_next_moves(valid_moves(pos))
    end

    def update_considered_positions_and_return_next_moves(positions)
        positions.each { |pos| @considered_positions << pos }   
        positions
    end

    attr_reader :root

    def build_move_tree
        @root = PolyTreeNode.new(@start_pos)

        queue = [root]
        until queue.empty?
            current_parent = queue.shift
            next_move_positions(current_parent.value).each { |pos| add_child(current_parent, queue, pos) }
        end
    end

    def add_child(current_parent, queue, pos)
        child = PolyTreeNode.new(pos)
        current_parent.add_child(child)
        queue << child        
    end

    def find_path(end_pos)
        trace_path_back(root.bfs(end_pos))
    end

    def trace_path_back(child)
        path = [child]
        path << path.last.parent until path.last.parent.nil?
        path.map { |node| node.value }.reverse
    end
end


if $PROGRAM_NAME == __FILE__
    knight = KnightPathFinder.new([0,0])
    p knight.find_path([2,1])
    p knight.find_path([3,3])
    p knight.find_path([6,2])
    p knight.find_path([7,6])
    p knight.find_path([7,7])
end
