require 'byebug'
class Board
    attr_reader :grids, :player

    def initialize(m)
        @grids = Array.new(m) { Array.new(m, '_') }
    end

    def [](pos)
        @grids[pos[0]][pos[1]]
    end

    def []=(pos, mark)
        @grids[pos[0]][pos[1]] = mark
    end
    
    def valid?(pos)    #[row, col]
        pos.all? { |i| i >= 0 && i < @grids.length }
    end

    def empty?(pos)
        self[pos] == '_'            # self.[](pos) == '_'
    end

    def place_mark(pos, mark)
        raise if !valid?(pos) || !empty?(pos)
        self[pos] = mark            #self.[]=(pos, mark)
    end

    def print
        puts 
        @grids.each { |row| puts row.join(' ') }
        puts
    end

    def win_row?(mark)     #[row, col]
        @grids.any? { |row| row.all?(mark) }
    end

    def win_col?(mark)
        @grids.transpose.any? { |col| col.all?(mark)}
    end

    def win_diagonal?(mark)
        (0...@grids.length).all? { |i| @grids[i][i] == mark } || (0...@grids.length).all? { |i| @grids[i][-i-1] == mark }
    end

    def win?(mark)
        @player = mark
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grids.flatten.any?('_')
    end

    def winner
        win?(:x) ? :x : (win?(:o) ? :o : nil)
    end

    def won?
        win?(:x) || win?(:o) 
    end

    def over?
        won? || tie?
    end

    def tie?
        !empty_positions?
    end

    def dup
        duped_rows = grids.map(&:dup)
        Board.new(duped_rows)
    end

# Board#legal_positions
# This method should return an array containing all positions of the board that are legal to place a new mark on. 
# That is, the returned positions should not already contain a mark and also be "in-bounds" on the grid.

    def legal_positions
        (0...@grids.length).to_a.product((0...@grids.length).to_a).select { |pos| empty?(pos) }
    end # pos = []    
        # (0...@grids.length).each { |i| (0...@grids.length).each { |j| pos << [i, j] if empty?([i, j]) } }
        # pos
end
