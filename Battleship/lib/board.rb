class Board
    #PART I
    attr_reader :size

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
    end

    def [](position_arr)
        @grid[position_arr[0]][position_arr[1]]
    end

    def []=(position_arr, value)
        @grid[position_arr[0]][position_arr[1]] = value
    end

    def num_ships
        @grid.flatten.count { |ele| ele == :S }
    end

    #PART II
    def attack(position_arr)
        if self[position_arr] == :S
            puts 'you sunk my battleship!'
            self[position_arr] = :H
            return true
        end
        self[position_arr] = :X
        false
    end

    def place_random_ships
        while num_ships < size / 4.0
            @grid[rand(0...@grid.length)][rand(0...@grid.length)] = :S
        end
    end

    def hidden_ships_grid
        @grid.map do |subArr|       #grid takes in subArr
            subArr.map do |el|      #subArr takes in modified el
                if el == :S
                    :N
                else
                    el
                end
            end
        end
    end

    def self.print_grid(grid_arr2D)
        grid_arr2D.each { |row| puts row.join(' ') }
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
