require 'colorize'

class MazeSolver
    def initialize(file_name)
        set_up_maze(file_name) 
    end

    def print_shortest_path
        explore_all_possible_paths(start_idx, true)
    end

    def print_all_paths
        explore_all_possible_paths(start_idx)
    end

private
    def explore_all_possible_paths(point, shortest_path = false)
        if point == end_idx
            print_maze
        else
            if shortest_path
                this_point = point_nearest_to_start(point) 
                choose(this_point) if this_point != end_idx
                explore_all_possible_paths(this_point, shortest_path) 
            else
                neighbors(point).each do |this_point| 
                    choose(this_point) if this_point != end_idx
                    explore_all_possible_paths(this_point) 
                    remove(this_point) if this_point != end_idx
                end
            end
        end
    end

    def point_nearest_to_start(point)
        nearest_distance, nearest_idx, x2, y2 = [nil, nil] + end_idx

        neighbors(point).each do |(x1,y1)| 
            distance = ((x1 - x2) + (y1 - y2)).abs 
            nearest_distance, nearest_idx = distance, [x1,y1]  if nearest_distance.nil? || distance < nearest_distance   
        end

        nearest_idx
    end

    def find(symbol)
        @maze.each_with_index { |line, i| line.each_with_index { |char, j| return [i,j] if char == symbol } }
    end
    
    def neighbors((x,y))  
        neighbors = []

        [[-1, 0], [0, 1], [1, 0], [0, -1]].each do |(dx,dy)| 
            new_point = [x + dx, y + dy]
            neighbors << new_point if in_maze?(new_point) && (empty?(new_point) || new_point == end_idx)
        end

        neighbors
    end

    def set_up_maze(file_name)
        puts "This is #{file_name.split('.')[0]}"
        @maze = File.readlines(file_name).map(&:chomp).map { |line| line.split('') }
        puts "Start:\t#{start_idx}\nEnd:\t#{end_idx}"
        print_maze
    end

    def print_maze
        @maze.each { |row| puts row.join('') }
    end

    def in_maze?((x,y))
        x.between?(0, @maze.length) && y.between?(0, @maze.first.length)
    end

    def empty?((x,y))
        @maze[x][y] == ' '
    end

    def start_idx
        find('S')
    end

    def end_idx
        find('E')
    end

    def choose((x,y))
        @maze[x][y] = 'X'.colorize(:yellow)
    end

    def remove((x,y))
        @maze[x][y] = " "
    end
end

if __FILE__ == $PROGRAM_NAME
    m1 = MazeSolver.new('maze1.txt')
    m1.print_shortest_path
    # m1.print_all_paths
    m2 = MazeSolver.new('maze2.txt')
    m2.print_shortest_path
    # m2.print_all_paths
end

a="****************
*   XXXXXX* XXE*
*   X*   X* X***
*   X*   X*XX  *
*   X*   X*X   *
*   X*   X*X   *
*SXXX*   XXX   *
****************".split('').count { |el| el == 'X' }

b="****************
*   XXXXXX* XXE*
*   X*   X* X***
*   X*   X* X  *
*   X*   X*XX  *
*   X*   X*X   *
*SXXX*   XXX   *
****************".split('').count { |el| el == 'X' }

puts a
puts b

c="****************
*   XXXXXX* XXE*
*   X*   X* X**
*   X*   X* X  *
*   X*   X*XX  *
*   X*   X*X   *
*SXXX*   XXX   *
****************".split('').count { |el| el == 'X' }

d="****************
*   XXXXXX*  XE*
*   X*   X* XX**
*   X*   X*XX  *
*   X*   X*X   *
*   X*   X*X   *
*SXXX*   XXX   *
****************".split('').count { |el| el == 'X' }

puts c
puts d