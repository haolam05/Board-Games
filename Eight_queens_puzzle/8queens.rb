require 'colorize'
require 'byebug'

class EightQueens
    def initialize(n)
        @board = Array.new(n) { Array.new(n, "*") }
    end

    def print_all_possible_paths
        explore_all_possible_paths(0)
    end

private
    def explore_all_possible_paths(row)
        if row > border
            print_board
        else
            (0..border).each do |col|
                if safe?(row, col)
                    choose(row, col)
                    explore_all_possible_paths(row + 1)
                    remove(row, col)
                end
            end 
        end
    end
    
    def print_board
        @board.map { |row| row.map { |el| el == 'Q' ? el.colorize(:yellow) : el } }.each { |row| puts row.join('  ') }
        puts
    end

    def safe?(x, y)
        in_range?(x, y) && no_intersection?(x, y)
    end
    
    def in_range?(x,y)
        x.between?(0, border) && y.between?(0, border)
    end

    def no_intersection?(x, y)
        no_intersection_horizontal?(x) && no_intersection_vertical?(y) && no_intersection_diagonal?(x, y)
    end

    def no_intersection_horizontal?(x)
        (0...border).all? { |y|  @board[x][y] != 'Q' }
    end

    def no_intersection_vertical?(y)
        (0...border).all? { |x|  @board[x][y] != 'Q' }
    end

    def no_intersection_diagonal?(x, y)
        [[1,-1], [1,1], [-1,-1], [-1,1]].each do |(dx,dy)|
            x_c, y_c = x, y
            while in_range?(x_c + dx, y_c + dy)
                x_c, y_c = x_c + dx, y_c + dy
                return false if @board[x_c][y_c] == 'Q' 
            end
        end

        true
    end

    def choose(x, y)
        @board[x][y] = 'Q'
    end

    def remove(x, y)
        @board[x][y] = '*'
    end

    def border
        @board.length - 1
    end
end

if $PROGRAM_NAME == __FILE__
    q = EightQueens.new(4)
    q.print_all_possible_paths
end