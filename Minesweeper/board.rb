require_relative 'tile'

class Board
    attr_reader :board, :length, :width, :bombs_quantity, :safe_positions

    def initialize(length = 9, width = 9, bombs_quantity = 1)
        @length = length
        @width = width
        @bombs_quantity = bombs_quantity
        self.create_grid
        self.to_tiles
    end

    def create_grid
        @board = Array.new(length) { Array.new(width) }
    end

    def create_positions
        x = (0...length).to_a
        y = (0...width).to_a
        x.product(y)
    end

    def fill_random_bombs
        create_positions.sample(bombs_quantity)
    end

    def to_tiles
        bombs_positions = fill_random_bombs
        @safe_positions = no_bombs_positions(bombs_positions)
        @board = board.map.with_index { |subArr, i| subArr.map.with_index { |val, j| bombs_positions.include?([i, j]) ? Tile.new('B') : Tile.new } }
    end

    def no_bombs_positions(bombs_positions)
        @safe_positions = create_positions.select { |pos| !bombs_positions.include?(pos) }
    end

    def print_board
        print_horizontal
        print_vertical
    end

    def space(i)
        i > 9 ? " #{i}" : "#{i}"
    end 

    def print_horizontal
        print "".ljust(1)
        (0...width).each { |i| print "#{space(i)}".rjust(3) }
        puts
    end

    def print_vertical
        board
            .map { |row| row.map { |tile| tile.color } }
            .each_with_index { |row, i| puts "#{i}".ljust(3) + "#{row.join('  ')}" }
    end

    def [](pos)
        x, y = pos
        board[x][y]
    end

    def flag(pos)
        self[pos].flag
    end

    def unflag(pos)
        self[pos].unflag
    end

    def reveal_tile(pos)
        self[pos].reveal(pos, board)
    end
end