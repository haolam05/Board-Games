class Board
    attr_reader :grids

# Board#initialize
# Refactor this method to accept a number argument, n. The grid should be set to a 2-dimensional array with size 'n x n', 
# instead of '3 x 3'. It's worth noting that the grid will always be a square (meaning its height is equal to its width). 
# This will somewhat simplify things as we refactor our other methods.
# Consider refactoring these critical board methods if they contain any hardcoded values: #valid?, #print, #win_row?, #win_col?, 
# #win_diagonal, #win?, #empty_positions?

    def initialize(n)
        @grids = Array.new(n) { Array.new(n, '_') }
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
        @grids.each { |row| puts row.join(' ') }
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
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grids.flatten.any?('_')
    end
end

# board = Board.new(20)
# p board
# # p board.valid?([2, 2])
# board.place_mark([1,1], :O)
# board.place_mark([2,1], :O)
# board.place_mark([0,1], :O)
# board.place_mark([0,2], :O)
# board.place_mark([1,0], :O)
# board.place_mark([0,0], :O)
# board.place_mark([1,2], :O)
# board.place_mark([2,0], :O)
# board.place_mark([2,2], :O)
# # p board.empty?([0,0])
# board.print
# # p board.win_row?(:O)
# # p board.win_col?(:O)
# # p board.win_diagonal?(:O)
# # p board.win?(:O)
# p board.empty_positions?