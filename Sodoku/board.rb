require_relative 'tile'

class Board
    attr_reader :grid

    def initialize(name)
        @grid = Board.from_file(name)
    end

    def [](pos)
        i, j = pos
        @grid[i][j]        
    end

    def []=(pos, val)
        i, j = pos
        @grid[i][j].val=(val) if valid_pos?(pos)
    end

    def render
        print_horizontal
        print_vertical
    end

    def length
        grid.length
    end

    def legal_positions
        legal_pos = []
        (0...grid.length).each { |i| (0...grid.length).each { |j| legal_pos << [i,j] if self[[i,j]].val == 0 } }
        legal_pos
    end

    def solved?
        check_horizontal && check_vertical && check_block
    end
    
    def blocks
        a, b, c = (0..2).to_a, (3..5).to_a, (6..8).to_a
        
        [   a.product(a), a.product(b), a.product(c),
            b.product(a), b.product(b), b.product(c),
            c.product(a), c.product(b), c.product(c)    ]
    end
private
    def self.from_file(file)
        File
            .readlines(file)                                #read text file
            .map(&:chomp)                                   #chomp \n
            .map { |row| row.split('') }                    #split char "0","1"...
            .map { |row| row.map(&:to_i) }                  #to int: 0,1...
            .map { |row| row.map { |val| Tile.new(val) } }  #to Tile instance
    end

    def valid_pos?(pos)
        pos.all? { |i| (0..8).include?(i) } && pos.length == 2
    end

    def print_horizontal
        print " "
        (0..8).each { |i| print " #{i}" }
        puts
    end

    def print_vertical
        @grid
            .map { |row| row.map { |tile| tile.color } }
            .each_with_index { |row, i| puts "#{i} #{row.join(' ')}" }
    end

    def check_block
        blocks
            .map { |row| row.map { |pos| self[pos] } }
            .all? { |row| check_line(row) }
    end

    def check_horizontal
        @grid.all? { |row| check_line(row) }
    end

    def check_vertical
        @grid.transpose.all? { |row| check_line(row) }
    end

    def check_line(line)
        (1..9).all? { |i| line.count { |tile| tile.val == i } == 1 }
    end
end