# Remove dups
# Array has a uniq method that removes duplicates from an array. 
# It returns the unique elements in the order in which they first appeared:
# [1, 2, 1, 3, 3].uniq # => [1, 2, 3]
# it should take in an Array and return a new array
def uniq(arr)
    raise ArgumentError if !arr.is_a?(Array)
    new_arr = []
    arr.each { |el| new_arr << el if !new_arr.include?(el) }
    new_arr
end

# Two sum
# Write a new Array#two_sum method that finds all pairs of positions where the elements at those positions sum to zero.
# NB: ordering matters. We want each of the pairs to be sorted smaller index before bigger index. 
# We want the array of pairs to be sorted "dictionary-wise":
# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
#   + [0, 2] before [2, 1] (smaller first elements come first)
#   + [0, 1] before [0, 2] (then smaller second elements come first)
def two_sum(arr)
    raise ArgumentError if !arr.is_a?(Array)
    new_arr = []
    (0...arr.length).each { |i| (i+1...arr.length).each { |j| new_arr << [i, j] if arr[i] + arr[j] == 0 } }
    new_arr
end

# My Transpose
# To represent a matrix, or two-dimensional grid of numbers, we can write 
# an array containing arrays which represent rows:
# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]

# row1 = rows[0]
# row2 = rows[1]
# row3 = rows[2]
# We could equivalently have stored the matrix as an array of columns:

# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]
# Write a method, my_transpose, which will convert between the row-oriented and 
# column-oriented representations. You may assume square matrices for 
# simplicity sake. Usage will look like the following:

# my_transpose([
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ])
#       => [[0, 3, 6],
#           [1, 4, 7],
#           [2, 5, 8]]
def my_transpose(arr)    
    raise ArgumentError if !arr.is_a?(Array)
    new_arr = []
    (0...arr.length).each { |i| new_arr << (0...arr.length).map { |j| arr[j][i] } }
    new_arr
end

# Stock Picker
# Write a method that takes an array of stock prices 
# (prices on days 0, 1, ...), and outputs the most profitable pair of days 
# on which to first buy the stock and then sell the stock. 
# Remember, you can't sell stock before you buy it!
def stock_picker(arr)
    raise ArgumentError if !arr.is_a?(Array)
    profits = []
    (0...arr.length - 1).each { |i| (i+1...arr.length).each { |j| profits << [i, j] if arr[j] > arr[i] } }
    best_profit = profits.first
    profits.each { |profit| best_profit = profit if arr[profit.last] - arr[profit.first] > arr[best_profit.last] - arr[best_profit.first] }
    best_profit
end

# Towers of Hanoi
# Write a Towers of Hanoi game.
# Keep three arrays, which represents the piles of discs. 
# Pick a representation of the discs to store in the arrays; maybe just a number representing their
# size. Do not worry too much about making the user interface pretty.
# In a loop, prompt the user (using gets) and ask what pile to select a disc from, and where to put it.
# After each move, check to see if they have succeeded in moving all the discs, to the final pile. 
# If so, they win!
# Note: do not worry about testing the UI. 
# Testing console I/O is tricky (do not bother checking gets or puts). Focus on: #move, #won?
class HaveNotMovedError < StandardError
    def message
        puts "already at this stack!"
    end
end

class EmptyStackError < StandardError
    def message
        puts "can not move from empty stack!"
    end
end

class BigToSmallStackError < StandardError
    def message
        puts "can not move big disc onto small disc!"
    end
end

class HanoiTowerGame
    attr_reader :towers

    def initialize
        @towers = [[3, 2, 1], [], []]
    end

    def move(x = get_move("from") - 1, y = get_move("to") - 1)
        raise HaveNotMovedError if x == y
        raise EmptyStackError if towers[x].empty?
        raise BigToSmallStackError if !valid_move?(x, y)
        @towers[y] << @towers[x].pop
    end

    def won?
        @towers[1].length == 3 || @towers[2].length == 3
    end

    def play
        until won?
            render
            move
            clear
        end
        puts "you win!"
    rescue HaveNotMovedError => e
        puts e.message
        retry
    rescue EmptyStackError => e
        puts e.message
        retry
    rescue BigToSmallStackError => e
        puts e.message
        retry
    end

private
    def get_move(str)
        input = prompt(str)
        input = prompt(str) until valid_tower?(input)
        input
    end

    def valid_tower?(i)
        i.is_a?(Integer) && i.between?(1, 3)
    end

    def prompt(str)
        print "Choose a tower to move #{str}: "
        gets.chomp.to_i
    end

    def valid_move?(x, y)
        towers[y].all? { |disc| disc.nil? || disc > towers[x].last }
    end

    def clear
        sleep(1)
        system('clear')
    end

    def render
        towers.each_with_index { |tower, i| puts "Tower #{i+1}: #{tower.join('  ')}" }
    end
end

if $PROGRAM_NAME == __FILE__
  HanoiTowerGame.new.play
end