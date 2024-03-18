# Board
# The Board class is responsible for adding a player's marks, checking for winners, and printing the game board. 
# A board instance must have an attribute to represent the grid. For simplicity, give the grid the dimensions 
# of classic tic-tac-toe, 3x3.

class Board

# Board#initialize
# A Board instance must have an instance variable to represent the game grid. For now, Board#initialize does not need 
# to accept any arguments. Initialize the grid so that all positions are empty; this means that every position should 
# contain an underscore ('_').

    def initialize
        @grids = Array.new(3) { Array.new(3, '_') }
    end

    def [](pos)
        @grids[pos[0]][pos[1]]
    end

    def []=(pos, mark)
        @grids[pos[0]][pos[1]] = mark
    end

# Board#valid?(position)
# This method should return a boolean indicating whether or not the specified position is 
# valid for the board, meaning the position is not "out of bounds."

    def valid?(pos)    #[row, col]
        pos.all? { |i| i >= 0 && i < @grids.length }
    end

# Board#empty?(position)
# This method should return a boolean indicating whether or not the specified position does not contain a player's mark.

    def empty?(pos)
        self[pos] == '_'            # self.[](pos) == '_'
    end

# Board#place_mark(position, mark)
# This method should assign the given mark to the specified position of the grid. It should raise an error 
# when the position is not #valid? or not #empty?.

    def place_mark(pos, mark)
        raise if !valid?(pos) || !empty?(pos)
        self[pos] = mark            #self.[]=(pos, mark)
    end

# Board#print
# This method should simply print out the board and all of the marks that have been placed on it. 
# Feel free to style the printing as much as you'd like, but be sure to print out each row of the 
# board on a new line. This will help us visualize the board better as we debug or even play the game!

    def print
        @grids.each { |row| puts row.join(' ') }
    end

# Board#win_row?(mark)
# This method should return a boolean indicating whether or not the given mark has completely filled up any row of the grid.

    def win_row?(mark)     #[row, col]
        @grids.any? { |row| row.all?(mark) }
    end

# Board#win_col?(mark)
# This method should return a boolean indicating whether or not the given mark has completely filled up any column of the grid.

    def win_col?(mark)
        @grids.transpose.any? { |col| col.all?(mark) }
    end

# Board#win_diagonal?(mark)
# This method should return a boolean indicating whether or not the given mark has completely filled up either diagonal of the grid.

    def win_diagonal?(mark)
        (0...@grids.length).all? { |i| @grids[i][i] == mark } || (0...@grids.length).all? { |i| @grids[i][-i-1] == mark }
    end

# Board#win?(mark)
# This method should return a boolean indicating whether or not the given mark has filled any full row, column, or diagonal.

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

# Board#empty_positions?
# This method should return a boolean indicating whether or not there is at least one empty position on the grid.

    def empty_positions?
        @grids.flatten.any?('_')
    end
end

# board = Board.new
# p board.valid?([2, 2])
# p board.valid?([4, 2])
# board.place_mark([1,1], :O)
# # board.place_mark([4,1], :O)
# p board.empty?([1,1])
# p board.empty?([1,2])
# board.place_mark([2,1], :O)
# board.place_mark([0,1], :O)
# board.place_mark([0,2], :O)
# board.place_mark([1,0], :O)
# board.place_mark([0,0], :O)
# board.place_mark([1,2], :O)

# board.place_mark([2,0], :O)
# # board.place_mark([2,2], :O)

# board.print
# # p board.win_row?(:O)
# # p board.win_col?(:O)
# # p board.win_diagonal?(:O)
# # p board.win?(:O)
# p board.empty_positions?