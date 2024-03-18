require 'colorize'
 
class Tile
    attr_reader :val 

    def initialize(val = unexplored_tile)
        @val = val
        @reveal = false
        @flag = false
    end

    def flag
        @flag = true
    end

    def unflag
        @flag = false
    end

    def flagged?
        @flag
    end
    
    def bombed?
        val == 'B'
    end

    def revealed?
        @reveal
    end
 
    def reveal(positions, board)
        @board = board
        @positions = positions
        flagged? ? print_warning_message : @reveal = true
        update_val if !bombed? && !flagged?
    end

    def print_warning_message
        puts "You must unflag before reveal!!!"
    end

    def update_val
        bombs = count_neighbor_bombs(neighbors)                                         #count neighbor bombs
        @val = (bombs == 0 ? interior_square : bombs) if !bombed?                       #reveal current tile
        neighbors               
                .select { |pos| board[pos[0]][pos[1]].val == unexplored_tile }          #select unexplored tiles *
                .each { |pos| board[pos[0]][pos[1]].reveal(pos, board) } if bombs == 0  #reveal off neighbors of current tiles
    end                                                                                 #if current tile has no neighbor bombs

    def color
        return val.to_s.colorize(:color => :yellow) if val.is_a?(Integer) && revealed?
        return val.colorize(:color => :red) if bombed? && revealed?
        return val if val == interior_square
        return 'F'.colorize(:black).on_white if flagged?
        unexplored_tile
    end

    def unexplored_tile
        '*'
    end

    def interior_square
        '_'
    end

    def neighbors
        x, y = positions
        adj_x = (x - 1..x + 1).to_a 
        adj_y = (y - 1..y + 1).to_a                                    
        adj_x.product(adj_y).select { |pos| pos.first.between?(0, board.length - 1) && pos.last.between?(0, board.first.length - 1) && pos != positions  }
    end

    def count_neighbor_bombs(adjacent_positions)
        adjacent_positions.count { |pos| board[pos[0]][pos[1]].bombed? }
    end

    private
    attr_reader :board, :positions
end